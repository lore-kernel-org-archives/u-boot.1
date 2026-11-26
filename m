Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA68606A33B
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lLOK26Xs;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U4vnBqIR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C3A760AB7;
	Thu, 26 Nov 2026 13:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vWqz9iwqiTeD; Thu, 26 Nov 2026 13:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EED5A60A9D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700021;
	b=KD3hq56wLa4VA116UNEjbUF4geEYA0yPjMma29wmiZcTLqS06ZJPGp3IWy1AImbyahES
	 K/B0GdFspMpX9WG9Hc2GrLG6cdBloNrtXF6s3mUBljMtkg23id6YsGNAUjgG4pw9+puyO
	 tuhSG3d0oLsY47OtYK+w2+h4ckhG/3xmk3QifZmt69Hw8dHTuVs98LBeCU/mFAk/n+ime
	 ZXy//8Cwa7Os9F76j+Xr6lhE2yZWnjR1RKRPQvctc4LZfot3Kfv95+7zF+9ISaNE3gtzV
	 8rHG75cSrkI3FPFPCyNd/gPv8zuoV39aGKWQnnS1OkJCIwiGIN/bgaB79EHmePiDW5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DO4/h2OEHfCflrjH/aZjeQ1Yb9zV9/oPcgRokeywf/8=;
	b=e9vEDAJorTMsh7aj8+PA+tGH5vYQ7egPa3mivssyPxZa9YUElVEdECS1AvFSKpMRO9vC
	 pKWmDm5YG5DYDfkyLUbakDOFwj0yRBQ4UQA1mTN0yxcxw+sYl2hcXE4LnW9ecwecydOyS
	 VH94gOAorMVm7v0kVDUc4EcXccGpCgay3EgAopGoPD3exu9ZnF7qyH7AGFq7Z1sxAt3yb
	 sRMgOwgxyGAEu34tRJGjoBv6uNSJcGmZdlGr+oSyfs7ZNlTx1bzC7Wry22lMbxtH1FRT1
	 97Aq+7cCQwiZ3Y6u6SlUizzarKbFwH5S9YHWKSwpQOxegahJojZ5GrFonLzjRtuAmjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700021;
	bh=DO4/h2OEHfCflrjH/aZjeQ1Yb9zV9/oPcgRokeywf/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLOK26Xsh+ZtAmibOko6Z32ytFey/n499TZJLthuFgcUAEuZFjhugupW9t3VvTx0U
	 o8Dk6GHkY5MtodK9sy2LleGXdXx+9hCMfWBmCLTSGo8j2GRT2JfCTsh2G0KwpbcTPY
	 oTNF94Dg4wQYXBIL56E1Tu+vOIpEKZ63aBDqkBgO3VxazrvwU2dSVcNpXb2Mv/Oipt
	 q/B1i4aFCLeGnEMhSz3p4XikkI9XaLWZNJ/Gprg2c24ZqTJ2K50AorGDAVT51SwywU
	 ezq+A1M6nIGxSLxZJT2oE6rfAuKU+GBCM1smhf6PGi9eHaVk4guK7tC4o/d4VeVTrG
	 AAlVbQjQqLO4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EED5A60A9D;
	Thu, 26 Nov 2026 13:33:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38FC332D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F43A40492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOxJkVtdFGPq for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 743B240490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=U4vnBqIR
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 743B240490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:32 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-8253bc5a613so4207258a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676011; x=1796280811;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DO4/h2OEHfCflrjH/aZjeQ1Yb9zV9/oPcgRokeywf/8=;
 b=U4vnBqIRfImP19qEVo3XAPdiYN3KcPofh33n7rZEewRUexEGxQqsurq0aXknsM2Am+
 S9NBU7E7zu1gdBBTqpHOVLzW26AEHM7P/eIPwNadlFVBQAd3iuq+HeY6HtWxoiRJoV0f
 xXg155Gpli8HSpiX2x0aPi7LtI+MfxfXih33s5G3KMMu3JgpMSQqMWVA1O8yszHxGGQc
 N5e7/ZWM/3J7mOyzY6QVUch4dxDceyHl2kTE0hdFOCXTyDtiKi+Dp1alLdNOjeXJ2kpm
 3vl9XJmV2MCuMoTlR9mB5IYZOUH6NiEk6yW/k5rhhX63lXofNU14P7nNA9xgM6qqDXcF
 6kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676011; x=1796280811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DO4/h2OEHfCflrjH/aZjeQ1Yb9zV9/oPcgRokeywf/8=;
 b=T3HN1ER/PA0emZi1+k3S1f6UNn5Jh+nNWs0p0baCxovruijbkrYfmtXHKvQTBKkjEc
 czeZFsrLSbfZudFMKKla2GsFGt+HvfuMGZD2juF9I5N2B84ofBVLxDD4bnbBHdOuHNPe
 3vWhH6MH0V1hvFxcchBY420SgGCt92EaD6OZQGS7FPnrOlhcjfzgS5jBTgN+9wNE6GqB
 3UYy/9KaShZStRnAPZ+45BFGTuZugoMCxGCxK1djINT2OL7jXX2G1Otf18fASs2WqEeV
 WfjxqLTWgxBcoHWS7zlGI6DvIYPALyoWkrkG8v9L7f7cYBFjT0OIZCIQ8bY+uqJiytOp
 R/yw==
X-Gm-Message-State: APuU4Z9q0fsK049gNbYQZVofmO+N3V9Qol8QsIYacZJpr+m35goWcIpu
 zmkoaxYJAoJJrdceLMgoYUZpU24J33SLwelyKXO5IWsHkjeU9Rs0XYxY
X-Gm-Gg: AZFdTZcKnnyv+HQv7N8szQNiQwQJfuAH1Vk8r2lX/vJcYxMu8hzyZgpy6D3J7OVv2/1
 QmeBd2hyXmcsb0WYWcD50ua/UXYQKtosRJyNEJ528+OcDJhQ1WOjJNX+uApFlhXrM8zSEckcqIU
 4FmYcQykNuCQv9jcvqvsj9WQiiqjiq18hrgN2RPVyKeLipLTPfFgmVPmwVh0gmYmgZSX2LORbLB
 vsx46dGu6YJqMZkPTPl0YxiihD5IUVk3yIfCyPNe8bLSJ2d0noNjx42yVxpw/cHof6g0HnY3chT
 M5iaFNgxPAecbzKInRJMzq4Tx0Xp9rhV4Tpn924lCTPJWS+yTky0EtEqRQmhZefVN74ZKFiAA1i
 ZX0JphaVW56Eq2j4xSNQyrdjlBnzKF6PaDfdXpGezPg3J/aLI+fGor1XCcOGSyuHtijTmlXUbdT
 72bvYe2/rElWM/J8FFxGbLUwV256wte+WSJY7erKJsKNqQ/CltMrmNVG/TX0Hqiob6p5llEnmAi
 JN3vBVpfHEQn/S18mAwcvIYXTxZglH5Q4lIteXopHwQHKjZU7ykDMdv1SphUBeDwsZC9+Bpoogs
 VKteyupik25ajoH3l0qWPeq+g5B8Ew/0OrIbY0l1UXXilKSwJAlMjDCUUj0E6uP/KhtMrWdItlI
 rfF4dfFkrBudstgHF8aNcvxMvIKsh2rZ1ltq8mx2NS/9Vls2vNOGbWIDWbrQUYs3X5kI8kc0KIC
 PlL1jgwu9QDJTiLE/XDBFo5/e/4gkUq1f86Xfv0TUIglNtjvx3vQs=
X-Received: by 2002:a05:6830:680f:b0:806:d79a:c932 with SMTP id
 46e09a7af769-863159f2a98mr21026417a34.20.1795676011174; 
 Wed, 25 Nov 2026 22:53:31 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:30 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:01 -0700
Subject: [PATCH 12/19] boot: pxe: allow boot without the DHCP command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-12-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling the PXE boot method on a BOOTP-only build prevents U-Boot
from linking: dhcp_run() is only built with CMD_DHCP. PXE can already
fetch its configuration over TFTP when the addresses are set.

Only acquire an address through DHCP when the command is enabled.
Otherwise use the current network settings.

Fixes: 1915fdcc2126 ("boot: call dhcp_run in pxe bootmethod")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/bootmeth_pxe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 27f254b9f93..f6e95b03fad 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -54,9 +54,11 @@ static int extlinux_pxe_read_bootflow(struct udevice *dev,
 		return log_msg_ret("pxeb", -EPERM);
 	addr = simple_strtoul(addr_str, NULL, 16);
 
-	ret = dhcp_run(addr, NULL, false);
-	if (ret)
-		return log_msg_ret("dhc", ret);
+	if (IS_ENABLED(CONFIG_CMD_DHCP)) {
+		ret = dhcp_run(addr, NULL, false);
+		if (ret)
+			return log_msg_ret("dhc", ret);
+	}
 
 	log_debug("calling pxe_get()\n");
 	ret = pxe_get(addr, &bootdir, &size, false);

-- 
2.53.0

