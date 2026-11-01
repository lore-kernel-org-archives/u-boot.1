Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63869606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sFhuaYeH;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jKiAVkCy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE343405D1;
	Sun,  1 Nov 2026 17:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5JupPux8geU; Sun,  1 Nov 2026 17:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C50FC40552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553988;
	b=J9DU2Ztoi1vRihh8FHSNh741COZd2Pc8l/idVZCh/RA0xMBUh0HtaWd3Q/oP7/lFGsiC
	 ahxEH7aSgTlCfqitgu9oi5FBRXIpADEt1wO2mHkdrTEIN8D6v6veFk6TlwAykPjeE5o4O
	 bFm9A5BVHR3EZs4iEGBHqwG9Xz3D7CFhx6+meCj1yWPtvZC5rvBFs+dMvJxmJRGiqb1Zt
	 iHCV0zHzZwwjKzZ0w+5YHJGXaV9dh42Dmikbt3eKeTuUpBugX7tmkXl26JiD9oVjTffUx
	 +o+80+fX7sqyEpJ1njkllofLZRLtTFY7Rz3TGD4sZWC9W6OS9GubRvCMWcvC/rXkqjg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793553988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=16GpEeGm2iNFgiOSpnQ2VaxzxOBW8BcLF8fF0MzpMLU=;
	b=KOQLm2CoAknT7NiCuziUXJCLvDQ9ZgdcogiSNJfgGualZFY4e1XgKPSoNWqfB9xmM2Ti
	 LTvhNfE7LMbHXVX/8OJ8AZAH4AWOGOqLjXWKo0to5kih/Kt37wu32SHCIUM56e4EnWOfp
	 MRL0szTmFzmKtOrPGBH6V8fFteQ6kaAV7s0mnwQcjZxqIfzK967TQ8WK9H3vHQkzvNmPo
	 a8AxEZXOhufGiPa8yXAJTzJrsZjBl5kjlzapZAVAccjhMC8JOSOKG/vVj/NswkmF4auTS
	 JxK8HvHnaLLpuxwyuwHycaO7GaEBEN3p0jcOBUJ9VGnuR3WwAMm/CjCkgGfX5AarGRg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793553988;
	bh=16GpEeGm2iNFgiOSpnQ2VaxzxOBW8BcLF8fF0MzpMLU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFhuaYeHYbhK32Mnmz50NsY4SpLH+S033tCxR157xn/60ad645MNcwryNy+KKkSUD
	 SzCT4wXnbDxHQRS+sfnqo8TeOB2e8HnjZm63OBQ0gBtPcO+uROkAo5Rcciw/8cMs9a
	 UDVJ/IVBJTjIERXWjk9QRQJG9phP8iES8NsmK/3w7qyNL90Yw1f34cWHooIGT4I4dq
	 AXyMX69YKNT7NM+4I5Z5B4oB5Hd7uV7vunGCNDo9FOuB/A59HWBiMGfq+NKsUSi0YS
	 eB8TCn0PibHeYGGzm4bNWBK9M4iD9M4QJ048MQyFNwnsrgV+pkEIYHDoii3qfl5YZL
	 DFLAvZ3YCEylw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C50FC40552;
	Sun,  1 Nov 2026 17:26:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DEF73A7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F33CB80D2D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:26:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GLsAVN118emP for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 17:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6A4E80D1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553986;
 b=EYARoA26/NwlQ+IbWFJ9vESttBmhBWwOk6tMOsMioi7dIYjJt2RbMmtzz09vf3ppmBiZ
 OQ+7RMiJ7Qa2aGx+obFGbLIABtwoW24F2b2ynbxH0B4YsOdLaQkHIjt58ZayU8rIKOnLs
 m247IfP41Eh9N7jvougGLg7wuA4HSYgNdv57kD7YDJ9l95D7xLgpD0vdZTM+tntWAwGmu
 yF2S+mzbL2WNi/mRoe5/RnxnMZLuW45c5A1RagzWBME9tZKu8aqbTAfHWbpxzZ/u9vY/O
 1Dw2Z1ohi6qz2Jyy4OE/nQKbZrHfsXR+vnU+Lr88E1mzinb5hBYGjjn+qt8Ed2iQCUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793553986;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=16GpEeGm2iNFgiOSpnQ2VaxzxOBW8BcLF8fF0MzpMLU=;
 b=VytsoLFut4snC1oOd7QPIIWryj9a3RUYtqtvrlp2FXzm4a4reBqipP3WddI+4DezSDxh
 WjB4PK6ZJcrqIu0PnHMOJJg9jPFO2n6Y4m9e+MJ+G7qHeGDfELXug193V5E8xBXzX3iI0
 MmdbkqD3YdWJBWGvCVfHbrWhDVB0NEtPzW9KCGa9C/RdlvftcOnmbEwWkEobAsKvQ1og/
 4rE/LY9p5sUZlZh8IlK/kiejgJ/I0LF1/VbrmxrUd8dnt9XcOJcr0u3BY4m82sUYMVMrt
 93FOJ5ecSlPiMPSl2NUQpcDjdhDzczVy3Cx4fTYtey9Fsgu6hdabu4J33xnHncQGFAw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jKiAVkCy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jKiAVkCy
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6A4E80D1E
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:26:25 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c4caf490606so305653766b.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 09:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793553983; cv=none;
 d=google.com; s=arc-20260327;
 b=F9gpMxqnaTTPaquvjpoojhCXXjCTxiUPD9he1eznOv6eP7eVVF+oo4HOPPSN8b5GtV
 LL0XvuOWTDmRzuJ68cfdcTuF+LuW+Cnlyl4UfHJPZ6OiRcYj1y5KzamtAt/RjReuLbtG
 mj2ObS3f13cGohdvMHL5nB0H5RsaY0z/hp5IPQ2NN4ITg0x52IMKowps28M3nZHoCe7u
 JUtBs3ihWAwj1OUDpROZXMB8H/ugJILWGjoLCmk7VprZFdbwBNWRGDg028jY99xrVrPB
 qhTRJzfj2DxpcD469dmb06hNlvdBzPpHi9qnzGGRLwDqoWPZ07lKW5Vg7X6LVDCMhvr9
 OlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=16GpEeGm2iNFgiOSpnQ2VaxzxOBW8BcLF8fF0MzpMLU=;
 fh=EHZPdfdn75qHHG7Pi8U3bD+TfBB/d2nbVfMJFtRk+qU=;
 b=lVMAXhB6BysvWVtI8ffQLBZJ4ixTX3HCfVR+S+VsumgdD1Wv85V56CohJXBJSgxo1e
 CrWpA8qxTDmctHE7eW4Ggd1N1v1GKd5k6xsOt1aYmkJ5OkrVtEMCKh10NoNHWQbuGf5L
 XQbctglWybO1OaJ33+nd3VTLa4NjAJACaWPKkcgHvyO1xW6TaUIhaywMnO0UAawrdeO/
 XwUCKAMiJ8BSusid+fpoQ8pReEygpun0f/mOZD1+xIck7DEgvXkiojkh9icJkueh4FM7
 pq7qpwsI46vmeGJN7T3UHftAGRvu61EZFICLMcQtDjMzrz9WaXhEdoSqn93AWb6oqiOh
 ALdA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793553983; x=1794158783;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=16GpEeGm2iNFgiOSpnQ2VaxzxOBW8BcLF8fF0MzpMLU=;
 b=jKiAVkCyo7NXyDHl5iqxjI+YW5hVX1sEwaMnl90PI98OjP091aR0kxF7aV/Sgs6lp7
 5p67iNkRQO5iglZohyAeQXzbqaS4sBQ6JZrqWvfvNgLLgtfZwQTq4RW8kHD/+rfJYj1H
 rW9qn9O3zct63dn4CuVdCJliRLK2OmthD5XHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793553983; x=1794158783;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=16GpEeGm2iNFgiOSpnQ2VaxzxOBW8BcLF8fF0MzpMLU=;
 b=AQCC5IXjM5ZZh6v6ku5WDqjv2795kTmjsVhrMTiQuUQllHyHQlCIusBvZy0MYP71+d
 pIrSBy/imcj8SE98uo/z64whsuG7PtwRCiAKk3TO7i2jxKTnZtnUi3tjpCgLI32mswzT
 c+RG1Djjc0h0c9QOcaHJ4Cktv87YGz6jaUeUIHqUNa1TSA9hoMID1bW48CWaYQ9CKpYe
 JAzO9vJa/nKqoxpPRNhGcomOTBJ38RQlP/2STISGkt9eDm0CQTI5VEMtzhVb/m+E+HHU
 GWOmm4k/aIP3nYDWNsShg+rTatFTOGZbuYc3dYtVZjp+VX10wfkBRaI8Sly2bdne9udb
 byAw==
X-Gm-Message-State: AFq9FYIN6JKyWCt9VS0uJ1b98NtmJ5bQ0af1a8uXS8nZ1mzX3yW+PVOI
 HIYnZu49JHHZk/8Rs1pyqag6ScB8Kko8+4He2G9iOeL2kAxKFPYYx5FfKZ8kCczc2nadjaZj6tT
 6v2+1XpjBghCRPW877KpWn8MzGLT+e5SvT0SAeIgcIcrL0bP06xsHUtXr
X-Gm-Gg: AYBFou2en40GapX9EP78r8bX7GP9zbWiQKej2HeXWc4M/7eIWiicM4A9qTziJgr3Azg
 ZfS65dcQMJW/TEI3tW9BM8aIj87d1N5ysoGmzmITdTvTW63ybvJJzm3KMxEqOCZXkUcmNN44Um+
 ilNbuZTwt42z6NoKW+qM+J03CpnHW8OIe0d8JrF32w6JBYUbv6VeP6ODiXQ6tQysqXf+i+wM/1S
 ht49lwCxN4VvJeUzaHUkGjoKY2q5YYAysJ1YKqhH9qKvnIBKegPJBvsCwEcaprdB3b+QEqA1UBe
 xvBZSR0zpeekoynnYec7rbvGljOFgd4Fozrr6P8g9GcqUgQvXKzuroA0ZMGfTYl62t0Z1fQ8yBf
 FyyVuNzMqNMvgmoPDLaUcPvAtZ2Qbc0EZx/pbG+3/oE4ZdP/H4Mk6YU5bzD9pVUwnjly8BSw=
X-Received: by 2002:a17:907:3f95:b0:c29:4a1f:76be with SMTP id
 a640c23a62f3a-c4ca7a74b33mr593127366b.20.1793553983479; Sun, 01 Nov 2026
 09:26:23 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 09:26:22 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 09:26:08 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261031103603.1807331-1-maxin.john@gmail.com>
References: <20261031103603.1807331-1-maxin.john@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 09:26:22 -0800
X-Gm-Features: AclHuK-wzk5MFUgvKJJ4M5qyzuOf9ykXZT7dcZznyl2yA93ZnFMP6xeemoSAgeU
Message-ID: <CAFLszTgPk1qHE3Oy6kpCE97kEMZm=GBwmRQY8crpUoh4_K9mwQ@mail.gmail.com>
Subject: Re: [PATCH] doc: cmd: add documentation for binop
To: maxin.john@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxin,

On 2026-10-31T10:35:59+11:00, Maxin B. John <maxin.john@gmail.com> wrote:
> doc: cmd: add documentation for binop
>
> Add documentation for the binop command.

Thanks for doing this. Just to note that this relates to your earlier
series [1] - for the future it is a good idea to mention dependencies
in the commit message, when they are in a different series.

[1] https://lore.kernel.org/u-boot/20261028183154.823513-1-maxin.john@gmail.com/

Regards,
Simon
