Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80722C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 16:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5839080E09;
	Wed,  9 Sep 2026 16:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFFFbpDkNRvP; Wed,  9 Sep 2026 16:13:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5DEDD80DC0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788970417;
	b=RhrE2wdMNjpYGKxVzot1+I2SNYTUVBmYcrDOMnCeSkUfXRD4ynXVJ4BPqPOORAwRZ14V
	 HWXrc1yDXJZ5yP+5HQnPePbVUlPdQO8fEVReQ7oLC5oeeEZHv9pHKAeT2tU7kvrY9nl/C
	 TdYU/BfkXRO8eNJVtFM5wY3x3sMbJGr8HytxLizAuxCTwTBs6C5VZFEw02injFCb8NR5F
	 53lF1QPLQyIJn4tWVTsBOugIfldoZYCcajrnKcc0AbQSTzf4b6QZToIW1HSxxskx2/517
	 kZf67opyF/B6NkUfaUiwLWEHRosGs6AlpxvwKbmkT/mo6SaMfVd/1/B073w7QJ1VLAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788970417;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iM62Y7zqogR+qA/1J2pQIZCPkg/6MvFqwsqmp/Ukm2s=;
	b=ShYrrjfuzcIUaTJNBBYZPQsZYFz+hWoHKOd4ZomYgrkZJBh7mdjbDg6Jprjl2VnKjdFP
	 TBwxt3q6wZTIXNVuLePQYaTaF7qk+kk0eIvEfbcku8qB7C5boYBp+nEEPsAPJtcFLa//I
	 pLwrxNepvfKITdSCmrKeQLaPd9+WLw7vEHNcKN+b374vimE3hYnetWWJfQcZdQZJBVbh7
	 v4o9A86r5SUjNAvHJD9M+GvIvQE7+Pu7VxxhGgu6YQbP1ZAugJzIu59tDibuxHgcNAN1B
	 IIDFC+Rdn6GGrx3A+kA+TPoMrVaFYP9iK90eRvfWg/4uwSx4cQlj8dO31O7bQtEu7Jw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788970417;
	bh=iM62Y7zqogR+qA/1J2pQIZCPkg/6MvFqwsqmp/Ukm2s=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqRJ3brj+h/SUdflUjMNwpOxKQumSUJmIxi7pPMOeMofY1ug2+6wewZHLaUw8vrok
	 CgyFErSK8NGnBJF04kASE8jYaDjyKxJVoLMjeqfZaeg/2/hai5ORSmf/1XNKLOhsTN
	 hHBvU59sDYwHz4pVodHU2QJXGspH5XKhfKn1zO3HQV12A9sphTj05QjqENCUREL/29
	 rBveg3130PEfAKnxVYhehsfSO7Yfqe8y8FG9nsZjpfuzoNsoUdnm1Tf4LQO+FP7pxo
	 2G2xjBGK5f9AqXvs4MrcnBz/MRCospDV8Vs8PCCTHU/4nvRlgfHDzYTkLI2hRiBWKX
	 4WG64FzCXSGQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DEDD80DC0;
	Wed,  9 Sep 2026 16:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 56AC32D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47B9B407B2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S4q8_WbJWoS1 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 16:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9EA0D407B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788970412;
 b=SRvCRa2+gbRm0o72dPkttDQlboLbYRBGJy5MT3d9KctSEIzoz5/ogZiX+cIBO01Yx25N
 EwxEFMXow3C+QqUcy8GTEM/lCnhsTfAow2r+bT/OAx32UW9RL8DQ/Sb+d+I51COfrmj6j
 i5ALP2TU6aJeteNfA6ZTnhINW+JdyAeaPnsBWkvfFxvBS+H6SMk3ra4Kh3M03MvqEN9Cj
 6kT4jVPyf3eQQARocAb6yd+ce+QmExbK4ugW0Yv3DigTC6EFWAxeeh5IFa7p81q3+GQ7T
 vPlCrlkEeBoKzChkvWliW4my1Ih1H81WMYhe3Hr/ZzWohd0rNj7JU6+dwNmGTPB1Sxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788970412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=iM62Y7zqogR+qA/1J2pQIZCPkg/6MvFqwsqmp/Ukm2s=;
 b=EkBQg3Oqtt1VTVoeP0w5ghMwYch2eIvC5wA8JvKZrt2wx0rPOpFcmsV/UIdg3im/13vs
 Avzfkl1gU8ddENx5yTviSBIASCoBPD6BF/qGRGMSJxSkWn7CV794ZIUgnzkyL+YFJSOVv
 JZyVbx93fyMj7r5ezniWqoFq63Nb3hg6pFKN4n8qZiPAoTtEbdEXtwoIRefQuO/zwsh9O
 DAF61tv/MLO1q9bqJrFq6gc5F+LYpzOZaumRt9NnByFHsSMn4oGN3TysADqtu2xnzKo6D
 RIXIAklC9KdVhZOaaQwK0y6f8tTe+F2tMpaiuI7RpdEHeyTB/iNdcgMFUIxh76FYJ6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oyfnDh8W; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oyfnDh8W
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EA0D407B0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:13:30 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-86cba60d4f2so46196927b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788970409; x=1789575209;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iM62Y7zqogR+qA/1J2pQIZCPkg/6MvFqwsqmp/Ukm2s=;
 b=oyfnDh8WpKv1HQz818ZdKjF9lZwLKNBYiif6aPdKa3oVwQEFjwj04ptAVSB+Pne63h
 JpyeC/ouqevvKGU6KtZVASgKm/7VAIkLXFcMCVzLILRrYkO7RqJsDajRi3fZ0hDXaX4H
 dTTeb+rksDA6aX5dDzDmFtxFobeu7hIK9JAi/fy1fQRODOLmRPdVBaQ5pcKrucrW9YuV
 iTEkhoZCgmCKpy1YyG7Th1+GFTjKN2oWnZXfQySMo+Nn61j9/7F/EpwvH/EdyLjc2mUm
 0fR1KtJQ4B0IYG6fUV1cHixnsfVboMKgTp0SirHE2s+PP4aF8e82fFfcVcPi0IEFqb/R
 kSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788970409; x=1789575209;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iM62Y7zqogR+qA/1J2pQIZCPkg/6MvFqwsqmp/Ukm2s=;
 b=UkOhnpRwyUZQJf2tbvSZASU6KoaTtv0VAPoZZgR/AGcErnbAyjrHkBhp0OdOgWD6XM
 iRdVWba9vN8WjyKjEUsn5PMIAx4kcOPxP2iv+DwZJzuvX2ONYDW5bLROmLKHYC79Xm7F
 usUDUqFIubgcPzXt66kk2qyXDe3HWKJyST9xLV6xG9Zhfgqn9496XTGbhj6ybLpl2yD5
 9N1rIYYxUHXm5Dv1aJutx2n33S/SK0L5vkqobhruRsoXZcqhvjrBsa/Xms+Xqkly8htp
 ivfbyTElTpvu3HOwN/cReFa/SpaTQjC06mmK0dwrl3MhLSxP2c+1QTm2nksSKLKm2blL
 30yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBziW5f6EfOcXXaldn6CM5CwWXz8h9dvSuS77cmq3hC7UeX9frT67blVlLGd7ReiMcNe7htPaOU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n+iOmzenQV9ENZHTpdp52n2KxzwTyovNf2ttsU2nfbDJzXaFnz
 vxHI0zw9kCm7xgmFNgR9mYU2krGFwZZb55X3VKsMW4xP5Hg7Ety7crG9c3uaKpZITRU=
X-Gm-Gg: AYBFou2NpjqnF7AZ9AFS2euvAbTdQTYjHBDZthiFlHHGvntXTIluVfgIPtVxp1NuNwx
 iSwXSD52xgPuZXo32I3vLe+NnS/b6rYAJNI9CttX+ER2FujqIFkPAaxv+WSR1hClt2mcD2MUaxw
 GdyZlnv97HVVgUxxB2i30tomNBXjSg7kILf7NibHamihlg0rtHuF8T8tT0oRVeN0v1dN/ltfeMF
 V6iKaA+0CtqddoW0BPUbYxxRCVVGSiD0pYVZyf/yexubHXYp6gMVHKAghBiPyLO5GHDlbnGuehX
 jjiQJ2Z/Un3CX0MJF6uhF5t47ZjxdYGYUkoJG4Bar/BvwQTVj4czfunfuCczEmyjx5tK/5ynag1
 Np51fXMSIvhMmIyy6ZGSxmFMDBDV4FnI7q78piXUVU4ARTgW/XSFh5hH5W5ZQ0nlsZHprXONrtH
 14XrL+yjSM8pwCOhGPYfc5N07wQ5+GU7MjtTg5i4VPVLahvywCyGQP02VuQSvPPcetWbcAD7bnN
 W6U/Gwox9tyrcaP4JQEzXp5Rb3U3OpXrkZdQANQGpe6JeZZcA==
X-Received: by 2002:a05:690c:c053:b0:873:5c6b:a301 with SMTP id
 00721157ae682-8735c6ba655mr91847207b3.47.1788970409038; 
 Wed, 09 Sep 2026 09:13:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3?
 ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0f0b6sm114023217b3.44.2026.09.09.09.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 09:13:28 -0700 (PDT)
Message-ID: <beee887d-b2a2-4338-89f1-380fde44162f@baylibre.com>
Date: Wed, 9 Sep 2026 11:13:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] ufs: decode string descriptors as UTF-16 big-endian
From: David Lechner <dlechner@baylibre.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, peng.fan@nxp.com, 
 jh80.chung@samsung.com, neil.armstrong@linaro.org, bhupesh.linux@gmail.com,
 n-francis@ti.com, xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 tuyen.dang.xa@renesas.com, yoshihiro.shimoda.uh@renesas.com,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com, jstephan@baylibre.com,
 hayashi.kunihiko@socionext.com, j-mcarthur@ti.com, venkyada@qti.qualcomm.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260807140119.324858-1-jorge.ramirez@oss.qualcomm.com>
 <20260807140119.324858-2-jorge.ramirez@oss.qualcomm.com>
 <9e05bc7b-be99-40f7-8c64-259e92f92148@baylibre.com>
Content-Language: en-US
In-Reply-To: <9e05bc7b-be99-40f7-8c64-259e92f92148@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/9/26 11:11 AM, David Lechner wrote:
> On 8/7/26 9:01 AM, Jorge Ramirez-Ortiz wrote:
>> UFS string descriptors are UTF-16 big-endian (JESD220), but
>> ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
>> host-endian code units, leaving dev_desc->model blank.
>>
>> Add an endian parameter to utf16_to_utf8() so the caller can specify the byte
>> order of the source, and pass UTF16_BIG_ENDIAN from the UFS driver, matching
>> the kernel's utf16s_to_utf8s(..., UTF16_BIG_ENDIAN). Existing callers keep
>> their current behaviour via UTF16_HOST_ENDIAN.
> 
Probably deserves a Fixes: tag as well.
