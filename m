Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CB0C5AC67
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E34607F6;
	Fri,  7 Aug 2026 01:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfGxs7bY74il; Fri,  7 Aug 2026 01:50:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78D11607D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067425;
	bh=jm6ZCrQHcbRUsD/9bnG/keXDruftcHfotGnTlCuWdak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RDQkjXevsPmfSiGas2ZPZ1U5gg2CDdQvwm2RWvBAgezCuoYcRP59lhutTR7qzaBua
	 pM1s3XSiMIX6hWez9sAEl0H0wHboX6Q+B+IfoWwutFQNS50qtqUjAfsMiz8KBDdPgS
	 gC8AnwL6eG0PAKoUneLxY8vGJFYAEBjJT47dUNDCLc4gyi6gwNHYeE2YXyLCkLlhW0
	 +JvKWWhPJhIaLhpvYpMutAx75YzmTNNmTACmjkJqk42X+2KWMaSeyEe3yYa7BasA81
	 T1AvlOpqR/qDPRguI5d5xD35kma1Gx6lG9bIgOZvKNXHyde7tcfwnhSuyi6lVpFP1F
	 qGJWU/fEmpGYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78D11607D6;
	Fri,  7 Aug 2026 01:50:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A43F9522
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A228980E9C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7yta9vk9UZ2K for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 18:38:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B52880BED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B52880BED
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B52880BED
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:06 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2020421077so423574066b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 11:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786041484; x=1786646284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jm6ZCrQHcbRUsD/9bnG/keXDruftcHfotGnTlCuWdak=;
 b=VGorRMiF2RLjhhAP7XTKCoCNd7D1J5uyP5s9RJxs2JRUMXofwMbrc5EHtuSgOscmuy
 DW90E69uogcood5QB9r5wxULVhGlB5C7ahatR8Ga4vy66gkb5hydX5bjukXcpvP2rU3b
 8Wcv3G2N1SILIeGxZNCivPMTIvT6JKM2gJmWtIxuSrscXHqDfo0A804AA1Jl0VNvRYSe
 QjcCyuOexGHikHYrAYvhtTGgJjkUvCg8gaCJguAD8Z5nYz1X87Vpivl3fb8QNU7POWMF
 oQ+CEtaLhB9XnIP0M2yrefN5mER1fOgTewoT6yCcJB13jgaz5rbEDSoDiBy7rfov108T
 iTQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpT9CO9FJuRzbivcdtv2usAASVXX8mYCc/XDbPWjroOhZ9yevhxV2zKTmwbZ2uhwz862Y1WJGk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyp0i8YBmmX9Vd+HToYtvRop1Q0TV9E8bSc3CvzotPmTITqw40T
 GQLtecjN66+J2vnJHSUhGU7HM20qDscQWDtsjoiyJv2WzwzSHWvmmZ/kP1eNYzF2rd5tjSHY+/X
 rYb0miG8=
X-Gm-Gg: AR+sD106GM9nKgqvmGvmMoObnMFWfmmlNtm07ciBDshColLFNi4H7WfEMjmJT9uwAcB
 O66WRBhawrK49oG6KXS9K6MMRge3dIqL8kDm0fJbJRy2qyonhqOZ5m9SQqf4hObTE6eRFcj50DF
 u6dshbRgKhJDPChGEel9RqsOVJJJ78B/GWBpOM4iRffMPlVqzateZCsSNZ1OnBBW18amau4Gzc7
 d0eilnMc7e1SICr/JklZIkcrjXPtfODfIEiAsBPXuwU/pzDpEwT75k9PjbdJ8uK2NZYUw7rMZFi
 1NPvSvGiGt2XwpD4ZxpdeW2mbtn5uNN7uzy0f2jcvALeZfPZ79zonrqbcX/VDLEXbTQACk4Eq68
 23CbVm4+byHDD5/EXVQ5AfpPaFdCn+YLHK2wD4AaaIf01hrByfgZshrav+Q6egPqkAlhE3DgVFH
 ZQfnkiOHHvNrpP9uwmozI9C5OEN3qvWE693GsF4AU7lXcmqJsVe0q4fWuWBwfWXahX4N/CrANIQ
 kaghbC/v4huQsV+vTZ+sIwV1yoC4mNJ26jWr4KlLpJZw9GUTEoRSw==
X-Received: by 2002:a17:906:4793:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c2039c214a2mr864991666b.20.1786041484140; 
 Thu, 06 Aug 2026 11:38:04 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00156d21543c815f45.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:156d:2154:3c81:5f45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c203642435dsm290075266b.44.2026.08.06.11.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 11:38:03 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 06 Aug 2026 20:37:50 +0200
Subject: [PATCH 1/2] net: dhcp6: bound received DUID option lengths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-dhcp6-serverid-oob-v1-1-4ec6857682e1@byteray.co.uk>
References: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
In-Reply-To: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
To: Sean Edmond <seanedmond@microsoft.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Argus <argus@byteray.co.uk>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786041484; x=1786646284;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jm6ZCrQHcbRUsD/9bnG/keXDruftcHfotGnTlCuWdak=;
 b=yPlO0T8ZkYvCxITDYfZW+MtFMjMBomrCGpSEm9hS73T3IHMwkDDst/gmr8tuzBZFq3
 9g4cSFwJAEBpRM2F1c/IMkpeVY9suBvrQgJRbtJAW5ubBz+svJ98czPyiVW16a26Al6X
 AEgLOQdpUNPJ53m137nbLJ4D/HINbK2J6FILgc50kqMyjslKpJ1LS266WcapzA8zhYDC
 ZholNaClImNoiW1cxkhPwaIeTxDHxoCZP6aJsj6VvH44F9QwwoKyxGlckgwHTXzTNhof
 BY3XhsWT9tCIqNHeOrByBsHwQgBeEq4aqF7IuzKZQj7j6frjCaLewoh1go9kgKDN05UH
 dj7g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yPlO0T8Z
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

dhcp6_parse_options() takes the SERVERID and CLIENTID option lengths
from the received ADVERTISE/REPLY and uses them unchecked:

- the SERVERID length is stored as server_uid_size and later copied into
  the fixed net_tx_packet buffer in dhcp6_send_request_packet() with no
  capacity check, so a large SERVERID overruns net_tx_packet (an
  out-of-bounds write);
- the CLIENTID length is passed straight to memcmp() against the fixed
  sm_params.duid buffer, so a length larger than it reads past the end
  (an out-of-bounds read).

Both are reachable by any on-link attacker that answers a DHCPv6 SOLICIT
during netboot; neither length is bounded against anything but the
received packet size.

Bound the SERVERID length to the RFC 8415 DUID maximum at parse time,
which also bounds the malloc() and the copy into the REQUEST for every
caller, and only compare a CLIENTID that is exactly the size of the
client DUID.

Fixes: a0245818f7f8 ("net: dhcp6: Add DHCPv6 (DHCP for IPv6)")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/dhcpv6.c | 12 ++++++++----
 net/dhcpv6.h |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 640f089a2e1..a18e358137c 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -322,15 +322,19 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 
 		switch (ntohs(option_hdr->option_id)) {
 		case DHCP6_OPTION_CLIENTID:
-			if (memcmp(option_ptr, sm_params.duid, option_len)
-			    != 0) {
-				debug("CLIENT ID DOESN'T MATCH\n");
-			} else {
+			if (option_len == sizeof(sm_params.duid) &&
+			    !memcmp(option_ptr, sm_params.duid, option_len)) {
 				debug("CLIENT ID FOUND and MATCHES\n");
 				sm_params.rx_status.client_id_match = true;
+			} else {
+				debug("CLIENT ID DOESN'T MATCH\n");
 			}
 			break;
 		case DHCP6_OPTION_SERVERID:
+			if (option_len > DHCP6_DUID_MAX_LEN) {
+				debug("SERVER ID too long\n");
+				break;
+			}
 			sm_params.rx_status.server_id_found = true;
 			sm_params.rx_status.server_uid_ptr = (uchar *)option_hdr;
 			sm_params.rx_status.server_uid_size = option_len +
diff --git a/net/dhcpv6.h b/net/dhcpv6.h
index d41a3c30615..b0207a9f2c9 100644
--- a/net/dhcpv6.h
+++ b/net/dhcpv6.h
@@ -37,6 +37,9 @@
 #define DUID_LL_SIZE		(sizeof(struct dhcp6_option_duid_ll) + ETH_ALEN)
 #define DUID_MAX_SIZE		DUID_LL_SIZE /* only supports DUID-LL currently */
 
+/* RFC 8415 sec 11.1: a DUID is a 2-octet type plus at most 128 octets */
+#define DHCP6_DUID_MAX_LEN	130
+
 /* vendor-class-data to send in vendor clas option */
 #define DHCP6_VCI_STRING	"U-Boot"
 

-- 
2.43.0

