Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E9606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KKn1DQR6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlrAaZK4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 791C180BBE;
	Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8Ilt4rj4Gsr; Mon, 26 Oct 2026 23:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C994480BD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058411;
	b=TUyMdQpwcB2eCPHMMD4NC3d7G3BQq9DqeZ5MjvY9FGtZiO1nUYYJZ1FIl6xcBA5Zcqp1
	 PeOKPXqFbpOFEBDwKMbYg51pOORjhbKxd3oqAY5WcoC7S/tv8y0P7kYM2LvQAj8edCd98
	 BrYHG0dycg3WSA0yhyTDQI9qJIHCc6ZsthngwSbVRcj+JT96sxFHRTcDcc1jSDBOUNpXS
	 AM5PvtxX3ruVLB5495mSCV9zI4GXqbVZSaCfn2tvlClbcb5i4D1CCPU4zY8Cw62Kv0qPP
	 c5QvavFJTWFQ1GMCjAoxXaEPQASjZSLZN9f/DPt+5xhcybxRqhdhQIwrFqseikRhM6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=B/pa0z5wxFqocCwMpJU6JHxYDqEcpsB0pxNJSO2/FrE=;
	b=ApDupfCAwTTEIBMXzt8YpM9OCURNOoykXOUZgBF/bYR2DSEtxDKZHFOYubC2n3Ijo5fm
	 IDPu7fj80cAQiwLnJim8MX8KO+f/H7kCB+9K0YBVEDPQkqAqlmKWA+4Yka6zzuugG/3oN
	 bb2VhVK3ylomIFjDnVmSeuXB6gJ/RYF0G5cOU5wwECXFVpVV25UCWmHZZnrbQBIux+QdL
	 nBujhQiQMHWbWBz28QeeXoWdskcpelyEWglfafv+1gxSL1BKDw1go5PJHAzzXx1Wdlxgk
	 wee+gAk6cmGpUbOeGvsWJfNG7rRC/dDxvhRzmCe3paYcbeHRriojgvZPNiCpo0pzOzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlrAaZK4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058410;
	bh=B/pa0z5wxFqocCwMpJU6JHxYDqEcpsB0pxNJSO2/FrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KKn1DQR65b/1oAd4GNWvVvaW5WsCfZgvd/KsTvqpw9WVXUcJ9UKR74tC0t/ybVp4d
	 f0FSVkx429okNH1itvRZVtLvQx905qg5/6rgm1Qb8/TF6JOkvavvmA6zHGJWxQiePe
	 9esqxA1vIChEvY5c+6xrF1PrSYWF8iZdbbY7BHs5MxhlFU1wejME8gvdJgEUusIKvj
	 m8a7xEhDfZNkt3tiU/o9AsZ7d6v9LVQGc5hkgrVmCEuKgg2S/zYYyJcejrUmTJwPZw
	 q0xUO52gWUjD05TpltmaStt/PjIymI94nykyTQNsISf30NCuoMfyimOAZjRRJMeD0l
	 UwQQw1n7vRESA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C994480BD3;
	Mon, 26 Oct 2026 23:46:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61E5C2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 463F180BD6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYt9tTQh1wjo for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5221280BC0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058404;
 b=dZubcGOha7pI5UgxfjKOgOxFkYQjfQWDg5yiw4hwAxdoTmVSnW1WEpzE7Zzcc8OCUht5
 PJSqXxqvYghM6ekP4fthsowtL4YOgpfrK6ZcCuGDUcx9SKlZHxwKZUefgaeh/Utg0374n
 GXeRBNWdE66yPNYgBpIj2uOvub1Yt4EJPldY7pZnZVqVi7moulvdFZJzyAvm5bazKggnd
 iv1y5xMu8Mh3vDkrzddSpCEJ9wpEE2pu0HZnFfebJFCkDluoogSEh1NdvEdjfT65AFn1u
 yKFZtPlzTfrsXJBBQJ1+cKs6IGnx7KD5cjwHNpLoCnbSJGpRkXSTMG5BDS2a/A0E4+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058404;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=B/pa0z5wxFqocCwMpJU6JHxYDqEcpsB0pxNJSO2/FrE=;
 b=cvPcdgFmv+ikLG9xP8yx97+xFBJMiFpu23izgSujC33F5UPNygi05PajiA42cQTeVynY
 zOqd+KJntIOVB5hwe4Ua4vTM6LUJ6vpNgiWD7JCDL5k8TKJ8+S0BK43Fokm1Mw7PnMIpH
 0rSskCaPpLHKbnioKvoc3zL54fhIFztCUMgM+m8wJpcg4Z2Fw1uBaiG6An0LNSoZbuu4j
 QdLX14RQW5OpSGqBht4KtnXccN5rLAIwp/us1h+AI0UyCeJRapOB4ZIZv9coVebhJUNBD
 ppMiQCqopp2dyT1DxV9N+UZvB/k6yEKvV/20O+yhZDzmYPvt7on+nNxaTcSy9fGS8OA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HlrAaZK4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HlrAaZK4
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5221280BC0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:43 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-84621d8c7aaso1639288a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058403; x=1793663203;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B/pa0z5wxFqocCwMpJU6JHxYDqEcpsB0pxNJSO2/FrE=;
 b=HlrAaZK4e43x0dMlkrgoqGPe37rs2HK28/qvZqaZMCbVUdj2tBu7OQ2BBlnWex1MXI
 jGyVxslfpgSl5wq3KxgVKtCzBEdF/mbkfH1yqbQ90bgn342wWExW52Lpndq7lS97/Ivf
 kjHcVk8Yj0813DvJo410+XFZSdn54J5fz+y+U1FYt45pdEuh25Hg5jBuZNQul1GkF0Ty
 AV9tBzD6AVQNPC4TmUCgemqAgikLOkQvAm0dJRvIASiQc7ZmdC/pM4QA9OuydUP+A04D
 nkDUgwZO7F/18C/qasxmx+YvD6H/neHUCt9lST239nGOjns+Zwszvvv/z+Pzvaj0laP+
 eluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058403; x=1793663203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B/pa0z5wxFqocCwMpJU6JHxYDqEcpsB0pxNJSO2/FrE=;
 b=V+lVe84kyWHI7SRik7itPGOffBdlUh/QheBUw2kJQ6LNyZgPvw+3xoEkfNXkFf10SK
 HkddOuQfZSoxMG8oaCzwPHO3Xs7f/6w8NHwRlGh1izVHxle4e2vSk5iYwGMzcqKXFBvs
 w3nYXTP/j5hQT+nDAoBMx8mTTLHw0cTvswRhlFIo/PRxSBEqNLH4VPuy2NTl1mT60AMx
 pAqlEJJ+rXjuErNMb+UA4se9STZQ1W4JupDPvjFWbKcEDidjl1/teMXScNRVx+jGugJb
 KAOBAdhdGpsyJlPxGwYxpCesgN0S3y0gPI65yHvsZBwsLi00tnYnCYolS0y6/u/3JRbr
 8ETQ==
X-Gm-Message-State: AFq9FYKIGX9lk8UtBUtwI7vjzvCseHwC8QLrOSdOLrCGKe7TDuWKmYTQ
 mUao9Hu3ootiZ+a84Qiu0pkJfHN1DXn8vZvGxXj1dIpH8IrKmz1xMMeD
X-Gm-Gg: AYBFou0f33E5nSJjHXN3nEqL1FsGAw+f5QpPLyeO7/4BLk2PB3QvU1cDvESMyq/b5ZA
 5POgXSk63DEJqHgkW/fbU33Zd2++2x6SMfjm4dLPc70QicyyMlOxMSHTd6DY9Jd4HuFHRu1Dw7g
 eLQ/qwg4MvfUdGNBJF9/XdCXmDvPLaQfKxbnRlaWelZ74HFcpfjY0cCNODYwlFSoQWpkhi9/wQU
 PJ+sQdrWT5Bg9Kl6a7Jjouf4fQlJSjZLBQ1g7QlKLI7hn7NSLohIDHMY8OA5H/33wcGm97SEH5S
 s9A1Eooh0SPTP91U2OWv7vqRQ4zQMtRpbw6D6x9WJz0aLnQx1dkaw8+O+QpLEyPuxpOcTRdxxqe
 7TC1Mx0ZVxl5sYliC3xE8tEWmxAzsxGR8ziIIPZmS7eUktDeoyY7y6kqWJpX/pBBKcKiId3QfQM
 ygECkP97Apf6eHvoUjTSPiiS1/kEGZHqEtzjm5tKNr0k2B7ak3AzXZO81kLjE4eo88AQYrjOesA
 Rg9O2DyNDuL9lKd9nYDPc+blyROPIF1wVHjtAP8vlkVhKAh6SY9cMl/AY87Qs4KTcc95HqUzrxP
 HcHtmsEuwH1MlIu2bacR8mHckZznHunOHrOnmGp9SzQCzzuOFTsJsxe9K+Vzfkco97AUtpphljc
 9koYOQRGXlR7mrS+FXxN29hk4SZtw1i3MUStz8JL9nkcw8MSCqBTYz7chq5/easCQmIn7mLAKXE
 Brbd8=
X-Received: by 2002:a05:6830:3e01:b0:846:5d82:8bc8 with SMTP id
 46e09a7af769-850f8c2560emr6648628a34.0.1793058402865; 
 Mon, 26 Oct 2026 16:46:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:35 -0600
Subject: [PATCH 3/9] pinctrl: sunxi: add the H616 EMAC1 function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-3-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Richard Genoud <richard.genoud@bootlin.com>

The H616 second Ethernet MAC uses PA0 through PA9 with pin function 2.
Expose the emac1 function so the pinctrl driver can select the RMII pins
described by the device tree.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index ab4e88c9918..099280ef76b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -738,6 +738,7 @@ static const struct sunxi_pinctrl_desc __maybe_unused sun50i_h6_r_pinctrl_desc =
 
 static const struct sunxi_pinctrl_function sun50i_h616_pinctrl_functions[] = {
 	{ "emac0",	2 },	/* PI0-PI16 */
+	{ "emac1",	2 },	/* PA0-PA9 */
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
 	{ "mmc0",	2 },	/* PF0-PF5 */

-- 
2.53.0

