Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09801CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E1346075E;
	Tue, 29 Sep 2026 00:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oYLf2L4vrlcA; Tue, 29 Sep 2026 00:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 48F3860722
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641336;
	b=PztXJ1py0ljBa9EtI9q5/AETyIJfnlHAsXnWQKZft/UxErHOZjN41MVlmWUoglWivYRl
	 aaITTru1FUfUk7yu2I0UJ2iHv/zS4ar+/7Ll+16BGLiiOQ0lrBJ1jSo/hBBNXP/7iyufj
	 Rj55LffS8GbxjpLpVIsudtDcblZzTjx3JffBYTbQO8rT8evSyIFcNPToyVEpNShs5ok9G
	 OKXYGkD1hNS4bGY6AFYsMrSNtun9E4fn36JDNSYMSmwwIhnjcEiRyoXdDKqGGVKyYXjTj
	 A7jHSsO+J7AOvgpFv9LXgChSeCP+8DdOwOQEy+78p4inGTmMqoJWtx3BnO5jCB7gxqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lN/PeSqyg5PRu5mmUx4SugXadZrRYKlslU47KOobgAM=;
	b=nFLLAdeOsR2VRE0eZXPEM4TuSB4JmztzRsDX6yu8WRnbGq+8liDwyP63kpxRZdGOpn8V
	 44Zhi2mFZjbQepmeErQZ3wlBEte0cPSk1WdAIzkNij5wJ+r4bJ9etQN2jZCPuZAr3oA93
	 1iVQD4Qxp73Pq1yKjRCjyakk1+NdWQTR6B4ALjo57jGMdFlU4yUkj6CTSoN6J5SZ//vvD
	 HvFpKbA5GEIlg7fqqVxAurH9ImP0fnTj2zofMMQUeuZkTgGvdCZMqog+YmplO7wJ7JQG7
	 JtsaLhrLbCCv5BTQ/+tX8afGqoqP7BLXGsKDk2Z0L9ZB8DhF1LTGzz77oOtOmo2WXig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641336;
	bh=lN/PeSqyg5PRu5mmUx4SugXadZrRYKlslU47KOobgAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7ms4qJuWJ2+LDqkI9HcT/1bW2+ufCGF3YZMU6W8MFN3MAOBpMZxBZSkPfoJXpTqn
	 jgLoujHJdlGcf4M1lO5f/LhyKSnsubIW55vOe8kX1kJtJ7n5dPu5FwS5UNKg0FoR6r
	 qxityl1WDveefijZycaHTfpCKnf+Qu3Y3i9j4p/QcvQZZvaVhY8PCq71hg8Dx2CaAT
	 CObAXMGBHr81Helm0k4gFmbv+puBKkeW1Nk2wse4k0YiyUeL1vyt4jqzyn28GnMgir
	 uiU/krVl4DyxppcYBJWhZqDNomoa51bjEZjumYKF97APaChWln4GiO9flK48yhyDjz
	 tPVVXkQemIiFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48F3860722;
	Tue, 29 Sep 2026 00:22:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3860F335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B92680C16
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6uQ3MMyc6oJP for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 31DDE80AF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641328;
 b=DTnD6FVwqhTJ2ZRM9R5DkIlCJJcWQ/PDogB+1kElFElvm4GNIPzD5KDAI/Xsr4LhLdHd
 yws/BfAtNkvG7ZWuJ9KRxRwxs53pnUiBZfRGVd99lfK7N0N5rykd/SpGLCb/xot05imNg
 I/BG0yrTR052zgVkBYjwUcU/xDyYSqpRzZrU2PhctFrY2IcVbb6+IPkrmsp3WaoQIDWGq
 siK6cHM2whSvjrRS+htWF6KueHPHQoqi4qHZFC0EWPhx/ww01d7Uay0bi3AzoYYW8fa7U
 3sQmfdS2JhqJk7m1YNGbSHtFbdBS/BmI/+8EnrQ44bR1c04BIA2zKuekyZXneCKsAwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641328;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=lN/PeSqyg5PRu5mmUx4SugXadZrRYKlslU47KOobgAM=;
 b=VhLKKVR1merlh7gSBySYD9JjYMtNjtj1JzzNx/DI9jJQ89B0pvLR1IDKL49THZPMpU/+
 4r52ZOM4ZzddA7tiqQ0AHP9+RGu7DX2WhFlkGLOEUI08fOrQgBUqM6ZsCPauNSMos+x/C
 mfoqTzK9KCvAF7jl8tj6BNnzF6lqEv5SUDfA/nHYObpC9ji+NsAQEngsstALHn81Ey45z
 zui4oye4tCgs9RJx297+upoBdoD5YDQX77xG3JP6GuEP0tFNNu0racrc2WLneS1HyHK3e
 El8OVnLVIpEyIK3g43Q6o0rTRGh1ePXk7jaGCk4larqUoPBap7YaCWbkABV+WA/s5+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cG+3A8ah; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cG+3A8ah
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31DDE80AF9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:07 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-483c65c2fa7so2069710fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641327; x=1791246127;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lN/PeSqyg5PRu5mmUx4SugXadZrRYKlslU47KOobgAM=;
 b=cG+3A8ahDKWS3skr72XwG0iBcHdItd94LZT81c+cDvUx6jYHN27K4jBxaNNiJuCwPS
 SfYMvC9/ln3AEZxj56UWq22+5F2wp7SPsCezjPpi6fa8jkeHxP56jxl11WwYSDljD65u
 fqtf0vv9iH9psHML+H+CR2bS3wZgUa8qKjaMbhmQxuw/0C7rnbPfvkYggmyuOnKhYyhH
 RN8UQNLIXHIoKnzeidqv7LNbkyvZWvxNlvXHdytNj+f4riX74nLVsWqnq11QvJn9MEm1
 cOKOhXeTlTElX5OcL50WNj72apEzXCqtNH/+kM8Ky7ZwxvJpRbzkkgIdNQdeIg4P4XZv
 bPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641327; x=1791246127;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lN/PeSqyg5PRu5mmUx4SugXadZrRYKlslU47KOobgAM=;
 b=ZmD+OGOdL1uB3P1lqPqIQry917S8G0XFyr1uMHPcPW9aqwx6PEDsADRlRR5KCJLUT0
 GVVmcdlCgmS6p7Tn1O7bqbvhD00Is93w1QYa/olfN6wSjbzS7QEIqmGyEh3i+/GNBJw2
 VgsWFBe4yI7o3ok3BBkRXpBMl4ecT8TQ4jLhhR1Z6vjP+J9C+WkBGv1L7rSKT7GD4z7k
 zYufUDD/M/eoq83WG8lGaIWOc2muH0hiE86zRw6qaMwjpgdK/fSDdjNI5VvRur2C93CO
 sa+uvdMHWdHVKVzAatJzC9P1KHAzmKzlkI9lxImreHxUypTPLn38fv4Q8T/ubVgKukrC
 wykw==
X-Gm-Message-State: AFq9FYKZpPWOsl22N3MZQVet9maVKstjwId/sboeemsLB4oH9wBGpF1j
 R0MNAimVAY8/bFBT913VqbTnfaWMjvo+Ap5XYFm2yMp4CB1qjPx49TnZ
X-Gm-Gg: AYBFou2dNCG+nXzm8ykai9d+Bnghqbz44E+x/KmlmJh2/qmrc05Lg7TrNrx60t3s71r
 f8Zszm1Qqg/okDiJe028P2Ja01pbKmImcZx9t3ujPDPQKEjc7xbBEzEc9HprTe2gWFCPJ4J3FTa
 GRBhJJTmGWUM5RTqyeyjbvg3dPwzJdLC1hUYP7cuYPni9Ed240clSx9x+g0iXOx1VrN6YEo3UJy
 q0nUJEfMMPDR2SQ/MOmsVUMcpWBa1/JynnyN8J0tPRtBdshuVgl1PgyknnjBaZ8SDJE+sftAZA3
 z/BNyYcdmXffSj+Xh9OAYGKo7vBXq3hnsgaPPqxiG+GacC0bKOv9K3765LXYJ+f4kR/THEyk5Of
 gpsrXExzK/zNgryKWGRcgJnHNVNmkXxIceeOCWIpIWiNTSB0bDrgour6m7eMO5NeUyLfYgDRs9v
 rvxZ/7SYVF8jMrdJmRCRD0JFGsiZ7VytNZpmNa2HZ6El9GVMQctLPNuYuMKer42+I7tqpMsollc
 yev1Lse7IVune9JvGDyrNqw4qnmCAb0oxvqcukhbiNrjSxKYQiXA73J4EycjEc1XAzJ2ILPhLYJ
 HF3n1mBevUFGPtqxHUHllUigLc42XdXICVOsTGtXDVZAq7X/jXpBdrr8ParZTmQS67AHztm7GMs
 chwyWZyd6sXtNxODOPBps
X-Received: by 2002:a05:6871:299:b0:488:7469:a223 with SMTP id
 586e51a60fabf-491e9fc524fmr13355953fac.18.1790641326881; 
 Mon, 28 Sep 2026 17:22:06 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:46 -0600
Subject: [PATCH 09/20] net: lwip: honor configured DHCP boot-server preferences
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-9-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

Expose BOOTP_SERVERIP and BOOTP_PREFER_SERVERIP for the lwIP DHCP
command. Preserve serverip unconditionally for the former and only for
a valid, nonzero address for the latter. When preserving serverip,
clear the lwIP-specific tftpserverip override so the TFTP client
actually uses it.

Keep the default DHCP server identifier and siaddr behavior unchanged.
Test configured, zero and absent server addresses.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig                 |  9 ++++-----
 net/Kconfig                 |  8 +++++---
 net/lwip/dhcp.c             | 20 +++++++++++++++++---
 test/dm/lwip_dhcp.c         |  1 +
 test/dm/lwip_dhcp_options.c | 29 +++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 69451cabc86..c1ae7a382bd 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2065,14 +2065,13 @@ config BOOTP_HOSTNAME
 
 config BOOTP_PREFER_SERVERIP
 	bool "serverip variable takes precedent over DHCP server IP."
-	depends on NET_LEGACY
-	depends on CMD_BOOTP
+	depends on CMD_BOOTP || CMD_DHCP
 	help
 	  By default a BOOTP/DHCP reply will overwrite the 'serverip' variable.
 
-	  With this option enabled, the 'serverip' variable in the environment
-	  takes precedence over DHCP server IP and will only be set by the DHCP
-	  server if not already set in the environment.
+	  With this option enabled, a nonzero 'serverip' in the environment
+	  takes precedence over the DHCP boot server. With lwIP, also clear
+	  'tftpserverip' so it cannot override the preserved 'serverip'.
 
 config BOOTP_SUBNETMASK
 	bool "Request & store 'netmask' from BOOTP/DHCP server"
diff --git a/net/Kconfig b/net/Kconfig
index e064c67e3ef..b8b37c09442 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -147,14 +147,16 @@ config UDP_CHECKSUM
 	  is wrong then the packet is discarded and an error is shown, like
 	  "UDP wrong checksum 29374a23 30ff3826"
 
+endif
+
 config BOOTP_SERVERIP
 	bool "Use the 'serverip' env var for tftp, not bootp"
+	depends on NET_LEGACY || CMD_BOOTP || CMD_DHCP
 	help
 	  Enable this if the TFTP server will be the 'serverip' environment
 	  variable, not the BOOTP server. This affects the operation of both
-	  bootp and tftp.
-
-endif
+	  bootp and tftp. With lwIP, also clear 'tftpserverip' so it cannot
+	  override 'serverip'.
 
 config BOOTP_MAX_ROOT_PATH_LEN
 	int "Option 17 root path length"
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 570b21f278d..2267a78f21c 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -274,6 +274,22 @@ static int dhcp_boot_env(struct dhcp_boot_data *data)
 	return CMD_RET_SUCCESS;
 }
 
+static int dhcp_server_env(struct dhcp *dhcp)
+{
+	const char *server = env_get("serverip");
+	ip4_addr_t addr;
+
+	/* tftpserverip otherwise overrides serverip in the lwIP TFTP client. */
+	if (IS_ENABLED(CONFIG_BOOTP_SERVERIP) ||
+	    (IS_ENABLED(CONFIG_BOOTP_PREFER_SERVERIP) && server &&
+	     ip4addr_aton(server, &addr) && !ip4_addr_isany(&addr)))
+		return env_set("tftpserverip", NULL);
+
+	return env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr)) ||
+		env_set("tftpserverip", ip4_addr_isany(&dhcp->offered_si_addr) ?
+			NULL : ip4addr_ntoa(&dhcp->offered_si_addr));
+}
+
 static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 		     struct dhcp_options *options)
 {
@@ -332,10 +348,8 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 
 	if (env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr)) ||
 	    env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask)) ||
-	    env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr)) ||
 	    env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr)) ||
-	    env_set("tftpserverip", ip4_addr_isany(&dhcp->offered_si_addr) ?
-		    NULL : ip4addr_ntoa(&dhcp->offered_si_addr)))
+	    dhcp_server_env(dhcp))
 		return CMD_RET_FAILURE;
 
 	if (dhcp_boot_env(&options->reply))
diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
index 57bbda2fc00..ac020470ec1 100644
--- a/test/dm/lwip_dhcp.c
+++ b/test/dm/lwip_dhcp.c
@@ -197,6 +197,7 @@ static int dhcp_handoff_check(struct unit_test_state *uts,
 	int i, ret;
 
 	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("serverip", "1.1.2.2"));
 	ut_assertok(env_set("loadaddr", "2000000"));
 	ut_assertok(env_set("autostart", "no"));
 	ut_assertok(env_set("nfsserverip", NULL));
diff --git a/test/dm/lwip_dhcp_options.c b/test/dm/lwip_dhcp_options.c
index a584c9bb19f..a02fb4883a5 100644
--- a/test/dm/lwip_dhcp_options.c
+++ b/test/dm/lwip_dhcp_options.c
@@ -272,6 +272,34 @@ static int dhcp_options_tx(struct udevice *dev, void *packet, unsigned int len)
 	return ret;
 }
 
+static int dhcp_server_check(struct unit_test_state *uts, struct dhcp_options_test *test)
+{
+	const char * const servers[] = { "9.8.7.6", "0.0.0.0", NULL };
+	char * const argv[] = { "dhcp" };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(servers); i++) {
+		bool preserve = IS_ENABLED(CONFIG_BOOTP_SERVERIP) ||
+			(IS_ENABLED(CONFIG_BOOTP_PREFER_SERVERIP) && !i);
+		const char *expected = preserve ? servers[i] : "1.1.2.2";
+
+		*test = (struct dhcp_options_test){ .kind = DHCP_REPLY_EMPTY };
+		ut_assertok(env_set("serverip", servers[i]));
+		ut_assertok(env_set("tftpserverip", "9.9.9.9"));
+		ut_assertok(do_dhcp(NULL, 0, 1, argv));
+		if (expected)
+			ut_asserteq_str(expected, env_get("serverip"));
+		else
+			ut_assertnull(env_get("serverip"));
+		if (preserve)
+			ut_assertnull(env_get("tftpserverip"));
+		else
+			ut_asserteq_str("1.1.2.4", env_get("tftpserverip"));
+	}
+
+	return 0;
+}
+
 static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_test *test)
 {
 	char * const argv[] = { "dhcp", "2000000", "explicit.bin" };
@@ -281,6 +309,7 @@ static int dhcp_options_check(struct unit_test_state *uts, struct dhcp_options_t
 	ut_assertok(env_set("ethact", "eth@10002000"));
 	ut_assertok(env_set("autoload", "no"));
 	ut_assertok(env_set("bootp_vci", "U-Boot.test"));
+	ut_assertok(dhcp_server_check(uts, test));
 	for (kind = DHCP_REPLY_BASIC; kind <= DHCP_REPLY_BAD_DNS; kind++) {
 		bool supplied = kind == DHCP_REPLY_BASIC || kind == DHCP_REPLY_OVERLOAD;
 		bool have_ntp = IS_ENABLED(CONFIG_BOOTP_NTPSERVER) && supplied;

-- 
2.53.0

