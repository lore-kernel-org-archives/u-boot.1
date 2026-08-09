Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D314C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FDAB80D80;
	Sun,  9 Aug 2026 00:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MK0bsmlKDk07; Sun,  9 Aug 2026 00:36:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD35E80D63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235790;
	bh=gNviHWgTziV5MTQAw9aGWnrALl1BQ6IIvcj+snhnqYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OLATJly81hcDOOjUmyjdh3DCIc/cyXDsOqt/gC2XYJ760SyAlNYHRzxSCscF3AmI4
	 x01CxKGD4hEEzRcyeXaVUqHA/Oypac18ZqQi7XJ4wo8/+w4lL7jyEXffD21dYANppU
	 jSRYdxxkee6GgnOxEvo/N5a5nMqKqeFdxOOC33s5mXmtmDhZki1bSiswPHWwbyjxEo
	 VY0nohfMzIk5eW9B1p2HD8iMx4tsZj5FGLw8ty8UGZaQ0g3z0ga55sibySpstL5KAv
	 hRFJ+6WpoFWIZ4ZcbPsrTLFKWb0DJKRNnbmS/J+7sYAw+wcFY9SSk/tZn2TLbG4HIa
	 mYfCq5ebGM1dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD35E80D63;
	Sun,  9 Aug 2026 00:36:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65669282
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B87D405A3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ES_PZ5Q8iXzW for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:36:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 14C9940582
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14C9940582
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14C9940582
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:36:27 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so1051063a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235786; cv=none;
 d=google.com; s=arc-20260327;
 b=V8jAyoWocTg4OBvpEpmpfhsseNc9jv3evBR0SzKNJpsCxlgnjhhkV7D6AhcIbL8Qr7
 VdeQP3zOcETfAlOoO/9JZI9DDyJOauJIaNnwAWvgmC3B61fQNqNGvLbe5sl7o8LsVwU4
 GQ8+rzYSBU4MqlCh/12dYHagFMcHbWhkhkJyODWQuyiSWxa8fHbUfo8fNKLBk+Bq2pTX
 FtEMURJN2Mg/zBlYIKT06dwDjL8SeeHnluJ5iybTP72GyQyAsgIRgx8yLEmHQxRXyEit
 gMuDbxg+cm6aADPunbDSJ+dDBs1UFdVSxVWfm3lYA7gmZpdIZJeBTyAt1yP2nzoJWsq0
 Mimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+VZK2PqiI0AspL3C+48II7k5DhZF5uGRVtyvUZV6e7k=;
 fh=VIRbU4OEeYkKJDNxBrSJLOjc9GTcV2bVOwLWC5txKw0=;
 b=f/cisI9FUgWqJCYBBqeZ5RO3yq6sH1CpvUy2J7UHWcrnaOoUmQ7aOmPYf+gBDgYjqy
 uKfzP0QVG3OHgkfLcJQSKbM7ed6jneQ3LiBVMr4k94MZWF2pAvc0fTSq3ZLm6V+hHXHZ
 4yTd0cswhY/ueqF8y642sC21cfbYchzbSsZWkkfgJohdR3sb6nBYD9w1nh6jE0iESyU7
 iD5qTaA8YKdx8ERI/ujPlYq1ndM901UzlKWzJWDGTj+VQPWfAjrXc3Kvd1K4APA44jXD
 FsxtnNERVMjBYuAqMV3xmY2VmTilaviCYY9QL7z4PqrY79S9zoCuhbJ0PSzvQ+/lLFM/
 WKqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235786; x=1786840586;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+VZK2PqiI0AspL3C+48II7k5DhZF5uGRVtyvUZV6e7k=;
 b=ATlqeAFMih7w64PTkg+0gVoJ8sW+HAQM1Jw79DWmJ8WnNSl/83mVaLlODQIkJ6nMyF
 A+pMUgfzG0sSc7r9gdlrF2kgRpo4ABcCvNN3A6ido7+3fJ8GFFPFfIYk9AemklI5pAm0
 PKAFOqlR1FC4UB4l8vfwqfHbjnl916PZLsj0Rnhrtn/L30iNSAkGjJVAS1V4Kud7XxAe
 Gs1aYHHZSNn2jO6MQomWSOzpoC2yofpgZyHyHsK3HK2AdN4CoRUUvlPMJsuKMLBObBLi
 V5OcCxTDzFVGe24qEUYCO46DRHXMRvAYDBLrkHvjG04uQUzlOzotW6xDtwBLJxXHvtVk
 Jm4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvB6n/Bcf5MStg0B5Wi+1oMTG+z1RPQpS1pTCgvFVM8SLTo/9J6S4YzEP9Tx5pmA8WJb/jNPo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxSHyaVCrkxins8MBjsb2+i7Hm1hCuXxVgmovk7uNowSVb9l/MO
 Iv4ouFLKCb/XEPmFXUexBTX6P9gsv2N8lUfw9/I62oZOAMksVQjwE/brSb2voCJAAKeW0uAtI0p
 rPwv9o3ypbwXnSYTVy9+n0bAv27+eWDs74ws84p5csoAWwN0LXWU=
X-Gm-Gg: AR+sD11OhAFGlI5KySRGB8De+nhrqvYCrUi9mh+FhydEM81/0/+DQFXVkBnpgr37fm3
 f3Yfl55FtTGpqwQh2gTUXZo2gAzLksDX464YsxcbP8/EW8tt1Jk7DpbTdWFp2EatzL2E0DhPgxk
 PzPmnXEFH+1JNgyj9XSeafXrDK2bdr2TkjtSLEh+jaKLeYtObtZxE8Ma21dybydutpwd/p0y6SL
 03EqSbQhKNKl/CjY6N+a3VkG5GEIWJYpEj8x1wDJTO5VqobLr8+e9uKdzKCqXxqZNvJe8lTKX1A
 puf6U2MvS/Bq2aH2A5PoT/RkpwNypiEBbjEKkNffWFU=
X-Received: by 2002:a05:6402:c4f:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a1f95b8f39mr3089686a12.4.1786235786042; Sat, 08 Aug 2026
 17:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260806204344.3069848-1-gsmecher@t0.technology>
In-Reply-To: <20260806204344.3069848-1-gsmecher@t0.technology>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:36:13 -0600
X-Gm-Features: AUfX_mwEPkqhTKoyx2zFBu1NL9f661xtU8FovJsamYP6cVgRtTd4EesqafpWXWU
Message-ID: <CAFLszTiLQQi4NKt8iNu4rwGOr+7CLT5sEx71=XWJgTHs7SS49g@mail.gmail.com>
Subject: Re: [PATCH] net: srand_mac(): fix -ENODEV crash with CONFIG_DM_RNG
To: gsmecher@t0.technology, Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235786; x=1786840586;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+VZK2PqiI0AspL3C+48II7k5DhZF5uGRVtyvUZV6e7k=;
 b=GKulgR1dBGEYlorwmRk7NxPd+MxIos5MU1tu5IOrpw68sfIWcVQGx+FA0F4OEQ4YHy
 LBtWpv2QRnfOZs35aebGSy/Q1hPUUNyWRfnVpyHB+TsWiewojx+xj14ZmPhSFioloDw2
 f3FmpOdO2mYP1xBd3BU6yakdoYJudMj6iFrhk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GKulgR1d
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

+Matthias Brugger <mbrugger@suse.com>

Hi Graeme,

On 2026-08-06T20:43:42, Graeme Smecher <gsmecher@t0.technology> wrote:
> net: srand_mac(): fix -ENODEV crash with CONFIG_DM_RNG
>
> The uclass_get_device() return-value check was inverted, resulting in a
> synchronous abort when -ENODEV was returned.

Good catch. This also means the RNG path has never worked: with the
inverted check, dm_rng_read() was only called when uclass_get_device()
failed, using an uninitialised devp, hence the abort. Boards with a working
RNG silently fell back to the MAC seed. You could mention that in the
commit message. I believe it is:

Fixes: ea707dc0aaaf ("net: Use NDRNG device in srand_mac()")

>
> Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
>
> net/net_rand.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/net/net_rand.h b/net/net_rand.h
> @@ -44,7 +44,7 @@ static inline void srand_mac(void)
> -             if (ret) {
> +             if (!ret) {

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
