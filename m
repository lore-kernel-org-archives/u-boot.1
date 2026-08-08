Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AC2C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:32:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAB87606B9;
	Sat,  8 Aug 2026 17:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEaBPCglDJAd; Sat,  8 Aug 2026 17:32:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BA21605FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210363;
	bh=fdMTvkWjT/cO5knJTjXf5bkrfg+eHYBs9PyvpDb0W50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=horX3DXYR4Ee7k/IE//nQXjvhHE6YUVPGpAImd8OS6AWhvhTmOH6JESMNbIbYkLjK
	 A4PffNi/p0qda3+nbRnXItZk748rMpwAbS5X7dEY7dH02VHbetLNV53UnksbG1vx7u
	 1PLdLuoh/39gczHrTxcoQHAw2el5CAZobEp5oJ2VWS9rWeiBt1nooUso00PSyQ6B2v
	 jDiQq3abgu2RV1St694pDIbFuRLDBmyNbHwU+taTKkGRClgN/sf10cPEjU0pKwvTe5
	 4qKzb1VF2QioRsznQVSGUBVbCSMURk7OzP7JDGfLwPRcYFVa1g80CmQT+A1E8DxDhV
	 yNe9RHRdC9vWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BA21605FD;
	Sat,  8 Aug 2026 17:32:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 072AE2F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED028405DC
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zhuWv-g45GZf for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:32:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0D8F4405DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D8F4405DA
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D8F4405DA
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:32:39 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a1995ac437so895303a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210358; cv=none;
 d=google.com; s=arc-20260327;
 b=rxw8mKmdx7upgD/xwK0Ob4T2Ovk5Yk6HLks1yLsE8OH1+rSoiu8yyqPsef4q1pBS/v
 WK7COgcHM1+z5gUUMeqLEIpF8Sq/G6Zcxs1FEPA+rEedycuzBaiQL6wFZ5lTruN3Imz/
 bzwtPmntjVRG0X0EhkadLo55uZUnZOJj4lZ5VQRRIf7xa+mlJ/CenUGbi6Ax4+toC6z9
 gT91mlt8Ewzde+jrv4zPLEG0OP1K+nQcqzpGu+sRwrgpoo/YXgJfq8lcK5ITcZYVxjSZ
 vbWi++BG4q0UoqbfUDBH9fPqyN3CKOy4Zc+QRm/2vjTSTL+2s6IfYaFJrY/hT5PJt9//
 1FkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fdMTvkWjT/cO5knJTjXf5bkrfg+eHYBs9PyvpDb0W50=;
 fh=aM5fUC7yAz3iSoHbBLnhV8pm9nnPXo6kLbt830m8m+4=;
 b=pb/QvJYnMw0NGYICaBVT5WdLXll8mHzJpaWcVWU1cSNwdXuJUENgVUCucyLfjuAUPg
 e70d0etkpNeg1+eDT5z2Nv4uXgpspBp1tlHMhWMqbypyOToYMyY9tmFB0oh/gt9Yfimi
 vnzzmCx2CiRaxbQG8XApZwpDvfStKcAQ9jKtNAP9WUPavCouJACxBbGPxsZoCDnhhEtE
 /8pSaG3a3sUoPQaaJn6Hdb5vn/eOTvOCUU5BMmcQ574YM+wy3YJUboweS62qVd9x9us6
 7Lh9aMd4Nfyw0lk0OPVfeMLM+65K9TM1e+UgRg2xpeoK739R0Hqsg4Y9Qi7rLbSrdTvY
 jyGA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210358; x=1786815158;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fdMTvkWjT/cO5knJTjXf5bkrfg+eHYBs9PyvpDb0W50=;
 b=QHbaqYD9uzWxd9QKdxTZo7nENgJEPt7+pzzvWWDdxcOeF4JgFfdhB2BZ3pQ7qLqsH7
 zIkw18LFRdRmaM65+rd/MvKcvXnZVGsVJSbsMYacC2rBfVvRwMRghUmbA8OAojGB1vvU
 kPHQyKOdcpA6QCUqvfl/jyyGU92jqvKOSBavaWnVjvq4A3sS0pWva2x83i72bmfcsdu5
 g8g/oLnsTJ0MNNRMwC4YlCj7Z8fZ61XEWXCpTEtT0xvrvWAWu45IHZk9XKzXjuvwnVGy
 BQ1rY/rE80jp+a5XpUToW4HxITIc/UthWOk8+MaFp4jV2/+W7WhKF9IvOA751pk1k2Sc
 Wfvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rocre5A6qbpHxCs3eb5shevhK82N+7FAJNqvs/DJnINMl5/5DxC8DHMsTibcYdOGDBmsQ+WDms=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw+4YKGKMbjBlDARSrUp8kDvi+PgTHg/KfXRBAUwGC497jvZonC
 8lSLvQWhAQwx0wUDSYECiEIRu6aUWxAX5NKNtrXGlohMuneIGsjzP5JGgpdWnEdRK2SGhKGSsCR
 TZMnfqvV7RKR+OAVkTVYQn06ZykAwhvnAG0pkH4Jj
X-Gm-Gg: AR+sD10UithbCaf0ANzCX2NcMOVhcq2EnKneQYp3xdxcHKPbwpBqfQmgrYY5AOqqB5r
 5FyTqfAsw10oVJ+RYbKuGCc20RANUt0QjSBVBCRJJuHWoo8ecNUAJ3lX8DKi6KxIzu/NFnCJDaz
 UOPltcLdYC7gbsPt2HvJLiDJqmUFURwROsENUrgURGLHDpPfoKMlJlHAYexI1Gca0MkIRzXYdKu
 Nqe3zQVJCVfEOmbj5RyvbjVuj+HB9BTBWzYKug/+9BLCY0iLAkwZQKyt10bdBvTa7QgsuLFYuQc
 dCbJ7XXxOAxQnHRzqm+scqjcrJkc6Cl7hqCt3VhKCOc=
X-Received: by 2002:a05:6402:3252:b0:6a1:6da8:a8d1 with SMTP id
 4fb4d7f45d1cf-6a1f4da49ffmr3024679a12.2.1786210357996; Sat, 08 Aug 2026
 10:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-3-jonas@kwiboo.se>
In-Reply-To: <20260804002643.2308515-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:32:26 -0600
X-Gm-Features: AUfX_mzCUZX7EVbX3ZhJdcE4-kpOYIK4SaKOyOch4rHzgtp0q_8tWpzTdT11NVE
Message-ID: <CAFLszTjPE85w92ONGRZhHiSuwnA3s88hh_bntKzGeY5uv9CbXA@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: rockchip: rk3588: Always init clocks in SPL build
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210358; x=1786815158;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdMTvkWjT/cO5knJTjXf5bkrfg+eHYBs9PyvpDb0W50=;
 b=H6Q1hGWObvjL8C2JmPBSSzs6cncOnvufMo3Af3nWydaja2JGKgS1r72c3uHVja/kH8
 zmP5sI7ck2jDiTRfJrhUChShPzaeS0kBWLh+MZ8D9/MBY1uzuzJ+8c+MyBupoLyJres+
 fPikv5PmpyfRe1l/8YUzS8dPixZabKztqou74=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=H6Q1hGWO
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

Hi Jonas,

On 2026-08-04T00:26:39, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Always init clocks in SPL build
>
> The CPU PLLs and SPLL are only initialized in SPL on RK3588.
>
> Ensure clock driver is always probed after bind for SPL builds to
> initialize core PLLs and clocks in SPL phase on RK3588.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> @@ -2138,6 +2142,15 @@ static int rk3588_scru_clk_probe(struct udevice *dev)
>       return 0;
>  }
>
> +static int rk3588_scru_clk_bind(struct udevice *dev)
> +{
> +     /* Ensure clocks are initialized after bind in SPL build */
> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +
> +     return 0;
> +}

The entire SCRU section starting at line 2052 is wrapped in #ifdef
CONFIG_XPL_BUILD, so this bind function only exists in an XPL build -
s0 are you specifically wanting this to only happen in the SPL phase?
If so, I think you should use xpl_phase() == PHASE_SPL

> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> @@ -2009,6 +2009,10 @@ static int rk3588_clk_bind(struct udevice *dev)
>       struct udevice *sys_child;
>       struct sysreset_reg *priv;
>
> +     /* Ensure clocks are initialized after bind in SPL build */
> +     if (IS_ENABLED(CONFIG_SPL_BUILD))
> +             dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +

Same question here.

Regards,
Simon
