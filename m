Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524AAC79FAA
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 07:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E493980D6E;
	Wed,  9 Sep 2026 07:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXe4eowKZLt0; Wed,  9 Sep 2026 07:12:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3604680D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788937927;
	b=ZjPstL32ASRmXxopXTMjOwDLbSh/XPxRhnT8i3CbwG5ecujDFGhQYhRWSp3khWowAYkz
	 EfsywXqeUgdtlLTdGWlQwGttFaqtz7zxbX1e4LmoNxQWwIv5Eh0/QY6WXJAFhDk6Sk9NN
	 vqQQjAmhhgJXzeOm+AoCIhKeoefRtXFmpCR0Wb2T9LJqdxonSgCBr5w2anNoF+7LrkEPe
	 26ncegCU3bav90V7mj9cYi+ib/CjZ9EENr9xCwLMmQb6uPTJqrz/k/opNpPDL8uyC57fu
	 R54WV0ifQfynbqn4TBHwaezMojSveclIKz4RCU48Vmf2RX+a0wKA3KEI2qxsUrEdd0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788937927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NOC0ikd0nckjMCLspqdnaDAs4llwj3zRRNZMEhTOw5Y=;
	b=FW4WgqOnYExDiX2TficjqHDRKg1z52ZrjRx76Rb681VlnBCvzi0E7q/ydIKww1cVNZxY
	 Q3oc25HnnMQOuZR6AU5isQw44fA9n2RvGa0h4/xv+0pjIUcY4iUpWPeNtb2QKJZ9Bs8JF
	 x0qewQVpAMUxrtAz0TuVXEgw9B5gWtSs9JiyhCp2hZ0gcjKbKIPQkYP7rPagPRvNmSquv
	 BjiZjf9YRtQe8oMqm4788mH3QCScblRhKDmDBprMsCMf8Nleg78SoiA+n6sN02sXSOHOb
	 0o5Y5drJP4JDAe6RsYesWsLnupiX6+EXjxec5FuH/EuX22sVIa20IZrDQ2F6Gc9oObw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nGFFsclO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788937927;
	bh=NOC0ikd0nckjMCLspqdnaDAs4llwj3zRRNZMEhTOw5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HNnRndRtsgrIwAsdXSWi0b0TpcCqfJVf9Ui9sPIo27970CSwQo+HqP1nk3JmUGzZV
	 iFRugX/6yCmr1CWGWmeKKvDPVukAnWXYrA20SgfaBMVpvsE4PosJAPYUJ8VPx/xeQ+
	 OU7quEB+xdDnfHZy0FNRrDKnDuLsowl71j6/v4twBbKXN9QgcVpl/zgk77MV8FQ81U
	 5+w2x7UuELYKkSjLaxLztefgRPus45lR+cpfLF4u3lvGycNUzgsm9OnFHqnYY1zXPZ
	 gw4mMEiobiDrjA5T9y9Q3wXyebb+OQYVQF5vkPD6yh3dKn8hRn8x6r371xQavseuMV
	 CwfycWPWwaslQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3604680D6F;
	Wed,  9 Sep 2026 07:12:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 241D7724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 153EC80D6F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sX0xI4cpT1JB for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 07:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 38D7A80D6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788937924;
 b=Fa9kvJIpcLWAYoV0tZYf42k6CH7Lb474dBZNkIP0j0R2qujtFvusjMhX3Qk4xknlblzU
 DhAurn8FgUuexg1uko3M26YrzVoyxZD32vPRrtggJHzCbirCHcM/0ixwSqFituL3hP15f
 wuXHnCV2LuosC3M+7DtAP9ApyWN7Y6xnG96Aq6yZVF7O5x3n4315W9woW20MRWk3qZsZq
 HySlHS2dHQeHa4Oqq6f5InZGKhOqlDpKVAwQDBuMz0AvNtcdjQTHUr6GDEeCc0Dyj+LRP
 OHdP4dRDq9X2po07gdMxtZbkfNdpmf2XSuOYbdQ/bwYJVTm3EMdoh4x8dEvs7f1UaZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788937924;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NOC0ikd0nckjMCLspqdnaDAs4llwj3zRRNZMEhTOw5Y=;
 b=jHuTo3knABLLnK6fVaKTBfezhUAAbR1HdsQ2JB2r6MsHmq0cgEDoKToptDq2wXm4krou
 s3uknTj4oXUb/3K/CKJmBAQapFprXfUADpcOourJjrfU88elnEnf15BjclKmUI2L7/TAd
 uRCrRJ+XQNZ5vrlnqPCe4/Q3OBZJOCyKf/Jpc8AFROsPz3qNTiGHVjemOK83WMMmU+zZj
 zvhnAFR/DSEbkccrt8izpFp5/E//qQbnLNSfQQreKctwFDOgomqHh7mUHCp8kv8C7UDkC
 oNdKWUn7cqa9Ws4AdO0s9S85IyhsZ2xdZ91nHeC5TIwXdfcB+ebm6+CxNMRppdfl2lg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nGFFsclO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nGFFsclO
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38D7A80D6E
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 07:12:02 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-86c0e4dd49cso70627817b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 00:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788937921; cv=none;
 d=google.com; s=arc-20260327;
 b=PWLeXYppf29MEE2bipVxuV2jg16zni+TL+X+hUWcDXIF8YV3gunjOIn+uH3DaLHmXO
 RD8bM6FAhnUgVDxeyWwrO0JmHMoIoyKo2iqa51AdTtjea7ZlgxLmQDSlXX+XOa/ODbKU
 m6Y292orBKffiLsnHS+myKMLcDo4Jer53CE+UxmVWakmrV/hDkM0T4M3+w5myrdZW0SI
 tPmakp+mdeIRqqi1tZms5Wg9DLOwl9D1BXy3gM5QuPbiYzMgeNXNytZThLuPv54T1h6w
 SDNmp1q0bFwkx+ZOHrqNfBR/ydDjFrkoUukA9I0pYQQgEIaLmskNJ5JEyhNVikH4ek2L
 riHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NOC0ikd0nckjMCLspqdnaDAs4llwj3zRRNZMEhTOw5Y=;
 fh=jFBvuo+ib4jA+vG9rFSDSOBPhj9gTYHDiJCnFxRsElk=;
 b=aJLuFXLM+fmLH75UhhK6SgR0euD981KuxHXG2iWRGuVhAT8LY627PlUHitrnsb3lhr
 Divcm9gPRqWye9o8qkakObIp8xgzyc+j7hEKCCbypSo2I//UKngtrroXWS94S/gXHkVM
 7wzDWhmkrPvBPxhzgdkKOgyKq2RG5jimxcdPzmH1tVOj2pLz6LZSOfkv03zGhhy7A+WL
 v1zF3UWPS/SAltE9NGpN0Cx+aib3da9NxtqlEfEwkKWpd/D3UJl2Z5fYCPhpmrPi9p56
 U4WWRZxsnPhdRX+OE5yX4z44ElopJZxdwwz86qpXzRg7ncnPWYzucjj6OVIQDYLL6DRn
 e14A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788937921; x=1789542721;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NOC0ikd0nckjMCLspqdnaDAs4llwj3zRRNZMEhTOw5Y=;
 b=nGFFsclOAvFDJSwfGNjeK9xgUgKVlvT3EtIiUW2SD0Rxd03Zx9DiFF1btG8u/s+Yj6
 Nlk/hg58o+/2Q7UQ9duIw+p54PAeKvE6oQNWnUNycYu31wSZC/E6Ej9n4CDp2sPTovVd
 6trx1t5BcXWtf+SNNr2hy6DRCEqqwt8bbA4jqUSlHxIBX4bEKuJsBecFlkABRCaZTo5D
 YS6a/bs9NLQ4bN8p/QBtoS9oZha9GWoggA5xkl6wDqsrUel4wc0n9ItigO/JsTm8f0+Y
 +tx6u/AH/tSotBFJs0SLwAyFkmNunfaKJCDgsHE8vAMV0D6lOOiQnZlmzqqnfCODdLPi
 M4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788937921; x=1789542721;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NOC0ikd0nckjMCLspqdnaDAs4llwj3zRRNZMEhTOw5Y=;
 b=LTR3GXKLwnpEgRaG/sDHa2oizzEeUdBKvmrD8U6Wfb6o5KJaqunG1b43Vu2N8mvDxs
 115z0itIw9ZY06yiRfuc3kCjrNSNNGNleFT36TJa6mc79XIly5ryLXUup2mXkC4ucjTU
 Nuij68xO4isGIKSIKOoYpFvk/W/+HwfZkCVHRbEzqsNNUqOhIPvBEgcakFarLTJ/DmP/
 TRuAXqJQ+QVXLw/70MZyZZt3qoIlPTwElz4i1/Udci0wv/bkF6WvzfWH8vTqdYxOfM8t
 n1OgMbOWrb0GyAerhnHcwNqGOtW/a278HpP6p7rDa+kzVmyn7KivFylvt0tZLPwp9MgR
 gizQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2Ydfib7YsW1+D0Oc0nmn0dNyNMo7GXuN7p1OSmEesoLxfcPSOfGyIOWHr8OsAVabt405iNhU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lVp7DBmAxFoOuV6p0xMCsLby2Bw3rQXHQuxdkgquR5fqo0owZO
 OtTKy1CjdiepFoodX4y9Rai8PkdRhyORAyeJYRzYzTHhAbtAOdi/aRKL85QO+QWksXUKRlP7RTf
 4B13ByLmJiNDsMzlU3WVrnhJSeEA/oSLUv48Q+dKZAA==
X-Gm-Gg: AYBFou3LWiz/8lY+imMIf+d8KQSxEjqXL5XgGHf9qeUz+xhb5ATdD82jx/5nJvOo3ML
 bVrK6qAate8n8poIyFXmJ0mHikEodbJtVI7+642+mQz70Ym4LWURhPgtEPqoU1znJa4QmWE0A6D
 Ppnuz0wDJHpPcedJ/XQvxSJjA6sJHAJpu+Qjh767wwvAkvWkgXANBiHeUHxRGvR1EccKhIhs2St
 sZgvlTTPiKeJBOmS8nSBZekF6h79h4nZOTiY8rAoUJ1vyCFDomQMdeVMG3M+zAjPt8qKMubTYwU
 Dx1fByy01sCkxWiHkn+RiLAVwyFtfxNdU0dgglXpObBxt4Dp8XjvYxpHl3h/obdB0Cc6DkRpPSh
 ejUF/I/GLXYuGxOT5Y6Vgy+1uja7haVLqqzdGr7quSqBS2a1BngrejNNcKmXI4Jiqtq6VAwL/wB
 hrdHS6uZFYPSJ7GcvMsz/fJ4SA1emCIceAi/e3IUwCCzUXphi4rSnYHkNDaZKRK2MvECAdEEi/f
 U7lpcma5sTM+sCGTxtJYCg0TCAohSHN785Y+yuvW4Z5IgEj2KCJnhJac5ByQ9RcbHMOWnH4IoYE
 MbMDwZXwEaxsN5FU0pecIw+bMuGsVt6mMq2txPC4yKgNOwi+uMSC3boN399aL4ZNUyQkKLgjgI5
 X7MvDTQ07RRBIQ9pNSdoDW1UMuXAXPDhNpqT5JebhMf2S73nhgvAVBA==
X-Received: by 2002:a05:690c:884:b0:873:5c7b:c0f8 with SMTP id
 00721157ae682-8735c7bc660mr88479547b3.48.1788937921171; Wed, 09 Sep 2026
 00:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <3c69f2bdf4a455ab8f0fe686e19e2c1a24c10721.1788879818.git.jan.kiszka@siemens.com>
 <480e5a19-e0e3-4b85-a09c-c4f0cc1760f9@altera.com>
In-Reply-To: <480e5a19-e0e3-4b85-a09c-c4f0cc1760f9@altera.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Sep 2026 10:11:24 +0300
X-Gm-Features: AcwNN1WNO8iS-GXWjQKkUEn-KXgLyexN_iuK60t80iVpi9lUehen6wMDEYTJNVE
Message-ID: <CAC_iWjJcE6x3DNcsXappEybbqc0RbrAw0xw7NP4KaZu_j9DscQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] mmc: Make "MMC Device not found" a debug output
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, 9 Sept 2026 at 08:29, Kathpalia, Tanmay
<tanmay.kathpalia@altera.com> wrote:
>
>
> On 08-09-2026 20:33, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Callers of find_mmc_device are generally processing and informing about
> > errors already, e.g.
> >
> > => mmc dev 2
> > MMC Device 2 not found
> > no mmc device at slot 2
> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
