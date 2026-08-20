Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739E1C5DF88
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85A2140598;
	Thu, 20 Aug 2026 12:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q_q1P_DXZmBA; Thu, 20 Aug 2026 12:45:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229923;
	bh=vjY4MPiSrSxR0e99gTH5IUv11IJqkFzybnHZG19lHlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tnyczb9nKl/8kKgl+Cr0ZpOPqxss41aonLO92Io2w/PmNcxap4HtELNzNme4af8FM
	 mcUhdsnozGcy8FsmNWDCS39lOzfYMG6mqMjXIk7VSMpCK+P9FQRpxi5+yU7HrvnAUz
	 NB48sFQosB6QNCGSLEMXP0nbH52Qr9u6rI7ZPWSySoxyG3pBbIiNlQocEBLSBzeHlL
	 DUapchDgL87IwsRM9hCZtvJ/+aojXluUslqhjbTtPXmR3gPqH/IqgbRV8cQ5+q6zXG
	 lqxktqW2sZmfgosN134Kkm2pqJ7CoA0ejl8nUS/vPWA0XR2HuwvYwvezLc476QU3XW
	 reWT3uYZc9scw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1BDD4056B;
	Thu, 20 Aug 2026 12:45:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E0883AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FF3140291
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ev-AsZ3Qyzei for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:33:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X4MiMuRa
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EFA640275
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:19 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-499840a2575so16638645e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787229198; x=1787833998;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjY4MPiSrSxR0e99gTH5IUv11IJqkFzybnHZG19lHlg=;
 b=X4MiMuRa6HgUHqqyvplSbyOELDhznRECNWhb/rgk/hUANp15/xfxlXIFkhe26S67Ye
 ZbXkbonVRumqieOHYO4mM8BiLskd+r2tnsEFjbPJigiftCHlH3Yki9kWoUfa2ycsXkrr
 A2+U4Tg34MnWoZjRoSVEch8RiHDhvVchqv/1QoJR+WsJunDk8ARBvH/cvipKH1VTB0mr
 LzbkuI2zuuLnLQyDM82JDgd1eHuE1KfJFpmWDDtf5vMOTSIcZ/VXEpBouyd0HKAa04q9
 6nws19SK+bvl0WruDeAm+TvEp1BHTqMFm7mfeCILUBxbIzLoJhIEYesfAD8KE2b6NTJE
 bP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229198; x=1787833998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjY4MPiSrSxR0e99gTH5IUv11IJqkFzybnHZG19lHlg=;
 b=VpBnC6PBKLSukLXxdYwFjwIIitdRGhXtoUqVw9U7R/qJ4PdBq6TbTpOuzo306JTse3
 F3bx/KafStZu/RdOZkMldACxqu2b+tmPMSLJWYgnEo2bFE4SO3PYkgMbm2UJxc8riTz0
 tf1snOo7gb/ln6HifRgHp5+o21ashue4bz+m8x2aCMPCZY1MTYlCu81Sjl/OGT/o/C3L
 2jVLOz8EBZiu7drJb0XNH4FN5CvJ1mYWjfTIIfjmVBS4jajBmstPRaZo7PTFDI4zjgjT
 ErYOEldJZ4PTvia7Rak9V2ixtmLvXUjNj4mJzVj6m8ypT/ACZlkwxsUGtgj/Y1SbmiHW
 ul2Q==
X-Gm-Message-State: AOJu0YzJuptqGZfkstJg3TOOYI35xVDiDBMyv7fZWR8OcMIpDFsYO/nm
 UvdvnigpFy+mfsPDPWy8WpW/fzWuxRJhX8DM3Qw6uWtmyk/PwSh7aslU8RRjmpud
X-Gm-Gg: AR+sD11AZ3V6y/f/URhvQbvQLFmpwXmo9R5gOR0XZjrShroexcNymx90jThWsTZUPZd
 U5UYn7FK80cp+HA9ZeoqVB9q1hturVLDYHzMQZq/x6JhEQvop6hmaOdq5q/NJzhZdu79XJAF9Zl
 RH25OHly7h+W/CTpmVT2i40Qc/E608MCwepkLiT11mRS38rPaLMFHB6R5G6n06WiX0u/NdAltiS
 Fv//o3i3UN6RWHASnGjE1QEH34SVWM3wJplutkjsmhazXqApW5V7xcLP0MjqLL47pMRcl1x5bva
 u/wWv/HyfxqCxV8bU/AvJg4eE4qoD3uRLXY6XjuF+YTaoSLkWAzXIjdJcQwrkRCk//B2Hjep3EM
 AELNa7C/Ci766K8sW8GVCybAglhraLrXH6a4D6lr6PjIBB73vR1eRvnxj1ToAMRTK+4PEznC6hk
 hmWEM8Dl0ntXnLK2jgPBx2c447VcyyVvGUsn0hcZnP6YytgDdWbVwpg9TcQAnbaMhy/IjG8/uUy
 +9JkgsYZIzsGo6M8tD7cpY+u0TZhN00Wl/c/4e+IjF+curS0HlpN8Uw4bRChOdy77uvWiIgEx7f
 YX1pFe1qoJveBq5yUaF7NQ==
X-Received: by 2002:a05:600c:19ce:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-499aa14e6f8mr191982345e9.3.1787229197360; 
 Thu, 20 Aug 2026 05:33:17 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784a4sm139126845e9.1.2026.08.20.05.33.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 05:33:16 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 1/2] net: bootp: validate DHCP option length before parsing
 it
Date: Thu, 20 Aug 2026 13:33:14 +0100
Message-ID: <20260820123315.9272-2-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260820123315.9272-1-pranavkasthuri@gmail.com>
References: <20260815220817.11754-1-pranavkasthuri@gmail.com>
 <20260820123315.9272-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:45:19 +0000
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

dhcp_process_options() reads the option length byte and dereferences
the option payload without checking either is inside [popt, end):

	while (popt < end && *popt != 0xff) {
		oplen = *(popt + 1);
		switch (*popt) {
		case 0:
			oplen = -1; /* Pad omits len byte */
			break;
		case 1:
			net_copy_ip(&net_netmask, (popt + 2));
		...

The loop guard only proves *popt is readable. If a packet ends right
after an option code byte, popt + 1 is already one past the received
data, so oplen = *(popt + 1) reads out of bounds. The pad case (0)
hits this unconditionally, since oplen is read before the switch
even determines the option is a pad.

Once oplen is read, nothing checks that popt + 2 + oplen - the option
header plus its declared payload - is still within end before the
switch dereferences popt + 2 onward (net_copy_ip, memcpy, strlcpy,
the option-52 overload byte, and the PXE config file allocation all
do this). A short final option with an oplen that overruns the buffer
is processed as if the payload were present, so out-of-bounds bytes
are copied into net_netmask, net_root_path, dhcp_option_overload, and
similar globals that go on to influence boot behaviour.

Handle the pad option before touching a second byte, require a length
byte to exist before reading it, and require the full declared option
(header + payload) to fit before entering the switch. A truncated
trailing option now stops parsing instead of reading past the buffer.

This is a prerequisite for bounding dhcp_process_options() by the
received packet length rather than by BOOTP_HDR_SIZE: fixing the outer
limit alone leaves this inner out-of-bounds read reachable whenever a
short reply's last option is cut off before its length or payload
bytes.

Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
v2: New patch, added in response to review feedback on v1 of
    "net: bootp: bound DHCP option parsing by the received packet
    length" pointing out this inner gap.

 net/bootp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index f0dc329d6e4..eafbe9e3bb4 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -863,11 +863,20 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 #endif
 
 	while (popt < end && *popt != 0xff) {
+		if (*popt == 0) {
+			/* Pad option: single byte, no length field */
+			popt++;
+			continue;
+		}
+
+		/* Need a length byte, and the payload it describes */
+		if (popt + 1 >= end)
+			break;
 		oplen = *(popt + 1);
-		switch (*popt) {
-		case 0:
-			oplen = -1; /* Pad omits len byte */
+		if (popt + 2 + oplen > end)
 			break;
+
+		switch (*popt) {
 		case 1:
 			net_copy_ip(&net_netmask, (popt + 2));
 			break;
-- 
2.50.1 (Apple Git-155)

