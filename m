Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50816C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECC4540BB6;
	Thu,  3 Sep 2026 22:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56pGJGl_q7jX; Thu,  3 Sep 2026 22:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A541040B9C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473627;
	b=sc61dxqPDETBya7MSu+1ShnvroywJwd0QvE43jwtOMd/oAFjJ2aY4X/4GvYS60VTq0+o
	 sXcIbBEc7moIVbBw2LyG7Nx+lGQjwzVCWPl9d1gVGEpH5/pEUTgikXN7yBOJrRrIDT/9D
	 LGDHJnznmHF4J9sXSXQVHAp7mdxXAQ5Gg1DGVjckPf6HeQqP3cgDbGY9ATB2Sx0Yw+YDE
	 ZUjh2DVHGXQeYPpgT7AvCoUQzb25U0jnIK6dB1aP2/FP9iu2oqK7DbGDm4bNoLdZqXCSO
	 NW/VHX5aiQStHb7akJXWeeT0PulFH7Jo4D+phDR6NTyWLs2D6/F7Gy5q9e3mIeseEPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B3PvuVhBfSc0r9B7ECOWMurOe4vDn1rdJnhORr8OvHI=;
	b=Q6DJ0u2DiIg3IY8VIIMZ+LsL3JRie5g0c/OS9wGkej7WeysSfVnoC4enyK95S5fs2WC9
	 mXGRxROjiySVOMws/AdSY6kG8ypV9PJawsIC2kWmbAzk87cX5+5/tioQ/KCyvmMKeb0ST
	 7GroIhXIXfvsaceocgvtUUuRsox0YFyWxtEpooURmtexSuLn2EiwWo9okVQhkteC87AAS
	 AbhZkm95QsOI8r4sNXj/WORX/OtX9/TcFCc3MosoJP3sIEcbTq6rmLnk66qsrYOSiWxfU
	 9MFdI2BUXQrfQESR3kwmhtqtKVyAlrchpDcHvPMWWQ05Bn5rmqUrN9i85TsKP1zXqcA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473627;
	bh=B3PvuVhBfSc0r9B7ECOWMurOe4vDn1rdJnhORr8OvHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbyGLx1xlRvZC0G1wOPmUHXb1+A+sgnAe/2mnvkeuxnPq4JRcZBqfaaLQ4QcJP6+M
	 phON9tFWQJP5LT6SaiG+FlCxGzWJ/2xiBghnSu+mJG8S+xMTl/bepIqBVwXeE1Q7sB
	 /uT/O+N0EwIuXCKCamDlLWY8zafVqFxaYS6O3pX9exexaZxN9Wvt1MKdyLSXX4lHa+
	 u8yJ6zxpHDuBF1ZAecJAeSOIeDGWM7DYB6+Imqi7BL7OWHRILRYN09r/nohRKWUp7I
	 HeVvQq6VwX7YWt4RgaWDACyzWL0nKDYQtIuAYt+U+L31bOyPs0w83SI+iLi7oxc5DT
	 9xm4FlBURzJpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A541040B9C;
	Thu,  3 Sep 2026 22:13:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EDB42FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80D5060B4F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Am-S9nVyvHi7 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C039B6070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471498;
 b=gT4ig+6brhtImZEbesTGBCbC7B18btn+v2sQauAiwmgKLsy9KYwrfYC0Qf+MIcIzzU87
 eBi1IgqzsngmdGzxIavN5L3u+0K4ELswdx+CKKdY4ELm4NWRSXA+WTf2d1CF/DnyJOb1v
 o5prNSxI+RETqZgT5C8T20SYZmguz/SdiyOx2x/Zv02agkhlXh66DLJATym/l9h/71dCA
 /kXzCtKf0phLnkiSxwuh6V6SE2iyCurT6PU9Ptl+DS0TSNXsDEG75L/Vqu31pyV/CMw9Z
 tSFJES8N/LZZAWWbiRZdxE/tlwKsky3xtbYTfA2aND5YNu/B4QBhJeQOmgFjysNUJjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471498;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=B3PvuVhBfSc0r9B7ECOWMurOe4vDn1rdJnhORr8OvHI=;
 b=HMxNzPCnr5HzDlF5kZP1x3AXdbItx7eiua+HyFcDeq2QNvL2Aqqysbo5slpWhrbi9eR/
 GzTigxLC81vxpEWbJG4WWOLYNIgYAd3xYyaBQXpNgqMPM0IPTFy4dh/ipR5uutjOQVmHu
 UUQjwv4A+xmRv+hmtdeu70j5i4OC0AS5s0qHlQ7Gl/l7z5BvNs3OwKNZxYj0bKsTJkvhm
 TNNN6wt0E2jLoy5N7pOVc4xsEG8442SSHpNg/MG9aYWw7hU9dp6b7RrSFKYbrd2n1h8L7
 kvkf62xKIoE1hb3aEvmXqGw+ouXqJUYBalPhet0zpHt6WurGiFio29yWKkvPFFw3zOQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hWpAzW8W; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hWpAzW8W
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C039B6070F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:17 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6b0496f4bbcso229754eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471496; x=1789076296;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B3PvuVhBfSc0r9B7ECOWMurOe4vDn1rdJnhORr8OvHI=;
 b=hWpAzW8WWJEwNHqnowwDD0AYqH49fAeMC6sJ8FbilNXswTveEvnZgI3hSXHX0pP3BT
 8SVsBpr/yZcTProyKmMTZcSww0KUI7y5dG+j7vzK+S4lTEauSkE6h0akyehfWcXbtuvI
 W99aLdUhD8GJkt/P3/oUPOggImiP8LrTtNroVJSxUJubaArMO1aYtZ+vdxWxRXyEm+7B
 0Sg+jcFZelDkx2vsWv+dwfi8Gp+ILOInLCExtTzmWrOJObJ3MsP18yW325jrCC1lt1jN
 q0fLeXhchwOCRjPB5oFqLt7kTplFDcRCiH7Kc5nHcd4WXREQTqhVSnv3QIv4oYoY3/2R
 Llaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471496; x=1789076296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B3PvuVhBfSc0r9B7ECOWMurOe4vDn1rdJnhORr8OvHI=;
 b=h2Kr6OXkae/jBOw43MxHtLGYv5OWJwWYwKtFYbTTiAAw5ZwLrySInNXT1EO+kX3ZWW
 nPm0ErlXma2h1PQM8ZG+IslQNYmgvmPe2la8AicMmganog232oxH9SFkh557JCo4+iiA
 6pp94Dp7KdqYpDDaPAGWT9gtfQdPDQZXg99CXX1RtfR1lEFesIfrT2Hl2nyRR1YIm0Q2
 +Imj3mG9uf3FeKeTiewTvcBrq4kaS0CJJwr5qowP6GSNgyGkOCFodgKWLzcHixHUIAcG
 zjKIstuND8ESB7h9ktjDs9p9cHLPBJ46H8tlr2EIdIDs14gS4trGV/UgCOrlxfE7tkNP
 Fz1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdyy3T+NXDBtQTSwDo4CLjukYioaxXZpJn7R4KAx+YYwbWwUL2mBc9EAQYmRIyo5V4YWXm5L4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mQGHWficE3ckcF7aV/oMVW2kFC3+Jrj9Qb5a5ycMC1t93UBf8g
 I2uNqEyxwFdkreNBBN9zQlJx5dkPxrX9Dd9h1nTlCOzpZsHmZrYMnqF/uvM8zRln/4M=
X-Gm-Gg: AYBFou1GJd61nY987Rx4SD79dai8B8LXRp8fk83NL9QiBwurGHzkinyDuJb5FFqU0yO
 a/XiTEqhT8v6YI6Jpyb0ZqbBV7H4Kdd6HwWswUkvrdUrPa/HpubSJGFsaHTCGYtUVr2isZBdBp1
 9Y37HzxQlzz7LJBDBMcUZZK5NdoSBUNkNOENFC+hVKzxChAGYt85FIwvgdb1oIT21MLIl1vumlk
 RvOJd5rqaaLLDAOifRapbwx38yEeuOxJEeoNwzVatKqe1sCxESomjzyQVPVhJUg+G3VXRhEG8p8
 yZ1Dn3CgIrEhHYVk6HNpxvFrWsW7A2Q/AaRdoRTjMNcRGc7yWsO2kDjBDzLnCQ40993qXuFTTZk
 GpUD3iarZ1jJ38HHsLecgyAAR/yuY1ht8Vp+EiPG+nv4ecoVr2AC02I0bQOYBlCJgK2xy8CCzwH
 kB39ZiqQ75jyUd67GIB82qeFAQxa0Wg93iyet4Z+B/EPwL5hQUlrRQf0PElosmuA7FSw==
X-Received: by 2002:a05:6820:619:b0:6b0:ab1f:ec11 with SMTP id
 006d021491bc7-6b6fd8cfd5amr1548148eaf.29.1788471496168; 
 Thu, 03 Sep 2026 14:38:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:56 -0500
Subject: [PATCH 12/14] reset: ast2500: check dev_read_addr_ptr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-12-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CAwluykaJa5/x0zgh3XXvc0xlbx9z914eSouDKZYpBs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmeiGDuKjnSj9ktfsAX4moL2kX3HxvMg+oAYyy
 abw6ZUdyAuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnohhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AW5QIAIwPCqJySgNr49rjq/HzZy3pLRFN5FYq3vg3XRo
 8jmBnkpB3bQXdJlzzy4jtD4WzqPua2Tc2tgqwU6+Xx8VEyNU2WxRgHEvzzQPS5wklHgih5pT5mK
 A8hqO2rMJQkMY9QRqbmC/+tfW3YFe1MZJw0NstJ7z0OU/E0wsVluJOgP5XvgquBmtkA159xlzAP
 wp3eAz6+lafZnMG5qMtgKGQGNYY6KFkQ/RSV1EGWxGP3IKxLceGzP9RFPW/hCU0dzo+9ySQsTY2
 s7MX4VO4Puk8YGwrtQKCzJrFcZhTHGkscXQaAIgnCUfZWZSidjpZvBRPVuql6CcTKmJ9mQaOuvF
 soss=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_read_addr_ptr() for NULL instead of
IS_ERR_OR_NULL(). This function only ever returns NULL on failure.

Replace the now-unused <linux/err.h> include with <errno.h>, which
is what actually provides the error code this driver uses.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/reset/reset-ast2500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-ast2500.c b/drivers/reset/reset-ast2500.c
index c85906bbeb5..e7b4bb18cf4 100644
--- a/drivers/reset/reset-ast2500.c
+++ b/drivers/reset/reset-ast2500.c
@@ -5,11 +5,11 @@
  */
 
 #include <dm.h>
+#include <errno.h>
 #include <log.h>
 #include <misc.h>
 #include <reset.h>
 #include <reset-uclass.h>
-#include <linux/err.h>
 #include <asm/io.h>
 #include <asm/arch/scu_ast2500.h>
 
@@ -78,7 +78,7 @@ static int ast2500_reset_probe(struct udevice *dev)
 	}
 
 	priv->scu = dev_read_addr_ptr(scu_dev);
-	if (IS_ERR_OR_NULL(priv->scu)) {
+	if (!priv->scu) {
 		debug("%s: invalid SCU base pointer\n", __func__);
 		return -EINVAL;
 	}

-- 
2.43.0

