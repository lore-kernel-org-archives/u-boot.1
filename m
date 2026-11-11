Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF74606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g94qR9hb;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwzmWFyd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 539DE40DB2;
	Wed, 11 Nov 2026 20:11:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSZurHfksbbp; Wed, 11 Nov 2026 20:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 09FB140DB3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427900;
	b=lDsxy894LkSbXlp/XwQ/pHniHNpzgWD6sNPsBwb7uyNKjFZZnflWYvFn4HxuvUdIcmjU
	 Oi+0z9O6CwpzjU3pSZFvF87XnMTMEM07mFyJf+Wm5y4FqOMznacDDNx84vl2P/VoRdyc8
	 MsN8+/CLXBPFbdoJTdXEUryK2hNpsPGHRqwrD9hcnLzV6GR4msczYMEKH+fIqdEWzPWca
	 SzE+t+k9A41BcoPMmlxxtlzU1ayYKmlzmuGkBv4QV0Zj9SNWI521Ja51fXHwoYOK/WLEy
	 wVbdllmnK0O5W2jL6eYGPbiojJPCkZMcakpaAcTrcLi1bCMzKaKzpLjLT9QNh4zdziw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z11A6c+wwGCY3HbVdr53TLuXQNgm02Z85lgJvt0nq8k=;
	b=ohoMju2/29CM65cdXJHYvqzBw1NcPFzL0xxZ+kgfgbbe/d7YrfKRT2Zg5py0RExKiF0N
	 wdZA8afq+gy7JIFmks3YunPY3xzuP3ay4zIOmYHaNLQK5Mk+klELepWOUBEqZfN75zJPz
	 f75r5m/pbLao+ydr2ivISmJOuu4bZQAXdXCGnP5EwMvfwy1S9GMkPniFLZHR/f2kuZKil
	 pfBg1nI+HyF4DKguOxvJSq91ARHLtwf0JWMxBx1xPriy8goe5xwfZpDcV4pUAx16CAbzP
	 XyVcTmtEeae2bjSQWSWnUB+u1YaShDHpdDEyQ/9KYir8U2mjSSkd4W7AYkEx6SRVKbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427900;
	bh=z11A6c+wwGCY3HbVdr53TLuXQNgm02Z85lgJvt0nq8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g94qR9hbYMbW5anyWvKzHecSwKmceGU+6q0v3SZjJnNA9ZkzmZGkGFif0Q40QPphH
	 LL1i4KxnoVYqWaElKq7WXiQF/ZtkHPGqFSaVINT0OeBzb5TIak+JQQ6rf7Xn9jJvh7
	 Y2JbpXsPRhRSKc8eiTd/7QWnkT6VQmxQjjpUkjqx8YT8ybYUcX1Eo+h9D7SnHfaD3L
	 wzQ6FJ1da0MzBXSURBz+jLWfJFA4NRqrvyHwsq2Krfoy734+Aj4dGmG7QXKIAa71gC
	 BkOm084CYH2+qRF7Skfaa9g9bkbehz2EBFZ7wSNuRGBSVrfA3Uou/ougeQIuLDmCYd
	 daz9GDgJ3hUPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09FB140DB3;
	Wed, 11 Nov 2026 20:11:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 15584EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1232660DAD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1scNB857Rhyu for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59FC460DFA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bwzmWFyd
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59FC460DFA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:28 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-84621d8c7aaso1639235a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427887; x=1795032687;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z11A6c+wwGCY3HbVdr53TLuXQNgm02Z85lgJvt0nq8k=;
 b=bwzmWFydBZVDHgZ16+iNI9Oz2ffAkck8HtGH2psBxWtVs76JwmnRH3QviixlwyYtTo
 xFIi/ErYWT4pkOkC5cDLHTqSWqbtJ7j7RdDM9/oR4FUFKd3Re1BoDadAa8sqEWCSkee0
 MNwtvxKiJF/aTYPw6jKdONRkeWondXKXDfa24GEtK/+lGhpCJHk5uxz7OlaJCRx5KgtF
 UpTj3u0bFcygNa9OXkpu9hSFfsLwtwkYw0VwMPidK0RgAU1xmLARZGUhJtfjUWBZkdsN
 CpYt6b96pPGMMgxPh63iNQ9jJ5OB/DoWPOwcKV2vpvwAraM18TijRcpipnFId+vPkMGs
 bwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427887; x=1795032687;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z11A6c+wwGCY3HbVdr53TLuXQNgm02Z85lgJvt0nq8k=;
 b=mLbShSeEKguEWy0AOorxb79pu7W1W1SIdkO+MF5RLDgf+4xCro4USWC6MHkYdjBFx7
 bkPSiH4k3cRk4aAAebHhEXFnEFthR8PusjGBIenFkvCfg97NnrlWxgee6CMspUAxwQfY
 ONX5mJ2A8tc5plmsT5B1u5rvYuFlA22LdUQZ8TfDv3ZdTu7v1+PcR8Qxi0XPUyPs/tWY
 oEO7dSefaXYxNGjDvXgb6Vrwh1EbVK+7Xq1BesryNuGdt0LBHtxpHRXoObIECILbGJ3y
 uuo4VeV3Dm7gRoveK3n5s3EApPsptz3zJLLsZCfJv5SzpO7Joh4JeFEtX4T+UCjIT0cw
 xVFA==
X-Forwarded-Encrypted: i=1;
 AL+hErHpuAHhfc93n+4ci4wrXv3+1kSglPvcSFlQUE4eGt2sF42RUxytpGMqObyjS8LUpaHNkjtRhEk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+EF10/NQNFsC4RdpMxgeE/0I1lLluihj3lgmnVVH07Y/oPLhq9
 TDdJvBel6YzR4FB7cCGEpSPH4Cqifbe+g1WUMBwQNCbyR1Y8seqkwd2t
X-Gm-Gg: AYBFou2RnrQQ77LNNMQ9iuCVLhjnFHPotQd/R3TsAjtAGqJgMGQMBJecIKxOZ6QPZgK
 +F3FFh40xHwX6DY/2v2MKn18vy6hTUddRuslLv1w2Shrh4xdTU3IZWUzHCUrhjAz76xurHLLUsa
 WzI+noovbv2pj0Bq4RUDPCG3wodvBquOuz4f0Yd9arD31oUQinwRdQ06398W/Ze+4YoQ8DH5dTP
 tGLFq6FerPnkV40nriMV1nTla1GKk8xFKuNSdot0VLgPKgEoyIbz5CnBOPtcI9gB0FauxyDdNcE
 AZRoIyLydn8/sGuLmGuR9MbMyqfBUahkFUGM/BzPn5uCbgRsEMU5MhaXrQDFp46aDgY+liip/5w
 gX5Ppzu2800qerQYd+yYSgASmn2pr4PFI/nbPSM6FwdyFwkNrTPrLaRJ3ok9ggWMadwqQRVvb1P
 XASpsBFoJHaOlQ37IaddkqNnOZZeil1eZZ8T8liwPygwUYgh+c9wzrGw5hQHUkBViJh20Ep2cbs
 U3CqE9653omIk8tJbfIeDFqd692uu/UliHchX+mxqfbT/TrWk+CAqaKG2SdhsIwTRdVs2lCy5e4
 0x9r0b5OvjrFq7CUvms97axpsExrZwWASNFZToqyZAv+N6lv6svazHGNRCnoDCFAfAz6x8vtDpo
 YlZdxTdzIZdxiYwq1QehFqzea9CHEOefVXY3NmVCwYBZq+VkCDjo1OA9sJzpvvf+uWPglxC4jh/
 xZdCLYDgC20jHH3WDUxanHdBpKopb7H+5aHHSey+yOggVELyThyqfe
X-Received: by 2002:a05:6808:2387:b0:568:1e54:3d74 with SMTP id
 5614622812f47-56b97613496mr3304152b6e.39.1794427887417; 
 Wed, 11 Nov 2026 12:11:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:26 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:15 -0700
Subject: [PATCH 08/19] net: lwip: support IPv6 TFTP clients
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-8-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Accept bracketed IPv6 server addresses for downloads and uploads, and
support serverip6 with the existing final -ipv6 command argument.
Prepare the interface address before opening the transfer and use lwIP
neighbor discovery for IPv6 destinations.

Account for the larger IPv6 headers and minimum fragment MTU when
bounding negotiated block sizes. Require an explicit filename or
bootfile for IPv6 instead of deriving the IPv4 hexadecimal-address
filename.

Parse decimal transfer settings with bounds checked before arithmetic
can overflow. Preserve zero-port defaults and clamp valid block-size
requests to the supported packet budget.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/tftp.c    |   8 +++-
 cmd/lwip/tftpput.c |   8 +++-
 net/lwip/tftp.c    | 137 +++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 108 insertions(+), 45 deletions(-)

diff --git a/cmd/lwip/tftp.c b/cmd/lwip/tftp.c
index 2f4562487f8..10ca8c1ad31 100644
--- a/cmd/lwip/tftp.c
+++ b/cmd/lwip/tftp.c
@@ -4,6 +4,10 @@
 #include <command.h>
 #include <net.h>
 
-U_BOOT_CMD(tftpboot, 3, 1, do_tftpb,
+U_BOOT_CMD(tftpboot, 3 + IS_ENABLED(CONFIG_IPV6), 1, do_tftpb,
 	   "boot image via network using TFTP protocol",
-	   "[loadAddress] [[hostIPaddr:]bootfilename]");
+	   "[loadAddress] [[hostIPaddr:]bootfilename]"
+#if CONFIG_IS_ENABLED(IPV6)
+	   " [-ipv6]\nIPv6 servers can also be specified as [IPv6address]:filename"
+#endif
+	   );
diff --git a/cmd/lwip/tftpput.c b/cmd/lwip/tftpput.c
index 46e169aef2a..2beb6e9fcb7 100644
--- a/cmd/lwip/tftpput.c
+++ b/cmd/lwip/tftpput.c
@@ -3,6 +3,10 @@
 #include <command.h>
 #include <net.h>
 
-U_BOOT_CMD(tftpput, 4, 1, do_tftpput,
+U_BOOT_CMD(tftpput, 4 + IS_ENABLED(CONFIG_IPV6), 1, do_tftpput,
 	   "TFTP put command, for uploading files to a server",
-	   "address size [[hostIPaddr:]filename]");
+	   "address size [[hostIPaddr:]filename]"
+#if CONFIG_IS_ENABLED(IPV6)
+	   " [-ipv6]\nIPv6 servers can also be specified as [IPv6address]:filename"
+#endif
+	   );
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 2e1ce0969a4..9921fad3c0e 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -13,6 +13,8 @@
 #include <lwip/apps/tftp_client.h>
 #include <lwip/apps/tftp_server.h>
 #include <lwip/etharp.h>
+#include <lwip/ip6.h>
+#include <lwip/prot/ip6.h>
 #include <lwip/timeouts.h>
 #include <mapmem.h>
 #include <net.h>
@@ -274,23 +276,26 @@ static const struct tftp_context tftp_context = {
 	tftp_error
 };
 
-static int tftp_get_blocksize(enum tftp_operation operation, u16 *blksize)
+static int tftp_get_blocksize(enum tftp_operation operation, bool ipv6, u16 *blksize)
 {
 	const char *ep = NULL;
-	ulong value = CONFIG_TFTP_BLOCKSIZE;
-	ulong max_blksize = 1468;
+	unsigned int value = CONFIG_TFTP_BLOCKSIZE;
+	unsigned int max_blksize = 1500 - (ipv6 ? IP6_HLEN : IP_HLEN) - UDP_HDR_SIZE - 4;
+	unsigned int fragment_size = ipv6 ? IP6_MIN_MTU_LENGTH - IP6_HLEN - IP6_FRAG_HLEN :
+				    IP_FRAG_MTU_USABLE;
 
 	/* Keep uploads within the Ethernet MTU, like legacy. Downloads may
-	 * use the pbuf budget sized for full-MTU fragments in lwipopts.h.
+	 * use the pbuf budget, allowing for IPv6's minimum MTU.
 	 * CONFIG_TFTP_BLOCKSIZE is the default, not the receive limit.
 	 */
-	if (operation == TFTP_DOWNLOAD && IP_REASSEMBLY)
-		max_blksize = min_t(ulong, 65464,
-				    IP_REASS_MAX_PBUFS * IP_FRAG_MTU_USABLE - UDP_HDR_SIZE - 4);
+	if (operation == TFTP_DOWNLOAD &&
+	    (ipv6 ? LWIP_IPV6_REASS : IP_REASSEMBLY))
+		max_blksize = min_t(unsigned int, 65464,
+				    IP_REASS_MAX_PBUFS * fragment_size - UDP_HDR_SIZE - 4);
 	if (IS_ENABLED(CONFIG_NET_TFTP_VARS))
 		ep = env_get("tftpblocksize");
 
-	if (ep && strict_strtoul(ep, 10, &value)) {
+	if (ep && net_lwip_parse_decimal(ep, strlen(ep), U32_MAX, &value)) {
 		log_err("error: invalid TFTP block size\n");
 		return -EINVAL;
 	}
@@ -299,7 +304,7 @@ static int tftp_get_blocksize(enum tftp_operation operation, u16 *blksize)
 		return -EINVAL;
 	}
 	if (value > max_blksize) {
-		printf("Capping TFTP block size to %lu (was %lu)\n",
+		printf("Capping TFTP block size to %u (was %u)\n",
 		       max_blksize, value);
 		value = max_blksize;
 	}
@@ -360,7 +365,7 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	struct tftp_ctx ctx;
 	bool initialized = false;
 	const char *window_env = NULL;
-	ulong windowsize = CONFIG_TFTP_WINDOWSIZE;
+	unsigned int windowsize = CONFIG_TFTP_WINDOWSIZE;
 	u16 blksize;
 	err_t err;
 
@@ -369,12 +374,13 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	if (operation == TFTP_UPLOAD &&
 	    (size > U32_MAX || addr + size < addr))
 		return -E2BIG;
-	if (tftp_get_blocksize(operation, &blksize))
+	if (tftp_get_blocksize(operation, IP_IS_V6(&srvip), &blksize))
 		return -1;
 	if (IS_ENABLED(CONFIG_NET_TFTP_VARS))
 		window_env = env_get("tftpwindowsize");
 	if (operation == TFTP_DOWNLOAD &&
-	    ((window_env && strict_strtoul(window_env, 10, &windowsize)) ||
+	    ((window_env && net_lwip_parse_decimal(window_env, strlen(window_env),
+						 U16_MAX, &windowsize)) ||
 	     !windowsize || windowsize > U16_MAX)) {
 		log_err("error: TFTP window size must be between 1 and 65535\n");
 		return -EINVAL;
@@ -391,9 +397,20 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("TFTP %s server %s; our IP address is %pI4\n",
-	       ctx.upload ? "to" : "from", ipaddr_ntoa(&srvip),
-	       &netif_ip4_addr(net->netif)->addr);
+	printf("TFTP %s server %s; our IP address is ",
+	       ctx.upload ? "to" : "from", ipaddr_ntoa(&srvip));
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(&srvip)) {
+		const ip_addr_t *src = ip6_select_source_address(net->netif, ip_2_ip6(&srvip));
+
+		if (!src)
+			return -EADDRNOTAVAIL;
+		printf("%s\n", ipaddr_ntoa(src));
+	} else
+#endif
+	{
+		printf("%pI4\n", &netif_ip4_addr(net->netif)->addr);
+	}
 	printf("Filename '%s'.\n", fname);
 	if (ctx.upload) {
 		printf("Save address: 0x%lx\n", ctx.daddr);
@@ -404,7 +421,7 @@ static int tftp_loop(struct net_lwip_ctx *net,
 		printf("Loading: ");
 	}
 
-	if (operation == TFTP_DOWNLOAD && request) {
+	if (operation == TFTP_DOWNLOAD && request && IP_IS_V4(&srvip)) {
 		int ret = tftp_probe_arp(net->netif, ip_2_ip4(&srvip));
 
 		if (ret)
@@ -635,10 +652,15 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	ulong size = 0;
 	ulong addr;
 	const char *ep;
-	ulong value;
+	unsigned int value;
+	bool ipv6 = false;
 
 	net_boot_file_size = 0;
 	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
+	if (IS_ENABLED(CONFIG_IPV6) && argc > 1 && !strcmp(argv[argc - 1], "-ipv6")) {
+		ipv6 = true;
+		argc--;
+	}
 
 	if (operation == TFTP_UPLOAD) {
 		if (argc < 3 || argc > 4 ||
@@ -685,7 +707,17 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 		}
 		fname = arg_copy;
 		end = strchr(fname, ':');
-		if (end) {
+		if (IS_ENABLED(CONFIG_IPV6) && *fname == '[') {
+			end = strchr(fname, ']');
+			if (!end || end[1] != ':') {
+				ret = CMD_RET_USAGE;
+				goto out;
+			}
+			*end = '\0';
+			server_ip = fname + 1;
+			fname = end + 2;
+			ipv6 = true;
+		} else if (end) {
 			*end = '\0';
 			/* Like legacy, only an IP address introduces a server.
 			 * Retain the lwIP empty-server and numeric-port extensions,
@@ -694,28 +726,35 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 			if (!*fname || ipaddr_aton(fname, &srvip)) {
 				server_ip = fname;
 				fname = end + 1;
-				end = strchr(fname, ':');
-				if (end) {
-					*end = '\0';
-					if (strspn(fname, "0123456789") == strlen(fname)) {
-						server_port = fname;
-						fname = end + 1;
-					} else {
-						*end = ':';
-					}
-				}
 			} else {
 				*end = ':';
 			}
 		}
+		if (server_ip) {
+			end = strchr(fname, ':');
+			if (end) {
+				*end = '\0';
+				if (strspn(fname, "0123456789") == strlen(fname)) {
+					server_port = fname;
+					fname = end + 1;
+				} else {
+					*end = ':';
+				}
+			}
+		}
 	}
 
-	if (!server_ip || !*server_ip)
-		server_ip = env_get("tftpserverip");
-	if (!server_ip || !*server_ip)
-		server_ip = env_get("serverip");
 	if (!server_ip || !*server_ip) {
-		log_err("error: tftpserverip/serverip has to be set\n");
+		if (ipv6) {
+			server_ip = env_get("serverip6");
+		} else {
+			server_ip = env_get("tftpserverip");
+			if (!server_ip || !*server_ip)
+				server_ip = env_get("serverip");
+		}
+	}
+	if (!server_ip || !*server_ip) {
+		log_err("error: %s has to be set\n", ipv6 ? "serverip6" : "tftpserverip/serverip");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
@@ -723,7 +762,7 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	if (!server_port || !*server_port)
 		server_port = env_get("tftpdstp");
 	if (server_port && *server_port) {
-		if (strict_strtoul(server_port, 10, &value) || value > U16_MAX) {
+		if (net_lwip_parse_decimal(server_port, strlen(server_port), U16_MAX, &value)) {
 			log_err("error: invalid TFTP destination port\n");
 			ret = CMD_RET_FAILURE;
 			goto out;
@@ -733,7 +772,7 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 
 	ep = env_get("tftpsrcp");
 	if (ep && *ep) {
-		if (strict_strtoul(ep, 10, &value) || value > U16_MAX) {
+		if (net_lwip_parse_decimal(ep, strlen(ep), U16_MAX, &value)) {
 			log_err("error: invalid TFTP source port\n");
 			ret = CMD_RET_FAILURE;
 			goto out;
@@ -744,7 +783,7 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	if (IS_ENABLED(CONFIG_NET_TFTP_VARS)) {
 		ep = env_get("tftptimeout");
 		if (ep && *ep) {
-			if (strict_strtoul(ep, 10, &value) || value > U32_MAX / 4) {
+			if (net_lwip_parse_decimal(ep, strlen(ep), U32_MAX / 4, &value)) {
 				log_err("error: invalid TFTP timeout\n");
 				ret = CMD_RET_FAILURE;
 				goto out;
@@ -759,7 +798,7 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 
 		ep = env_get("tftptimeoutcountmax");
 		if (ep && *ep) {
-			if (strict_strtoul(ep, 10, &value) || value > U32_MAX) {
+			if (net_lwip_parse_decimal(ep, strlen(ep), U32_MAX, &value)) {
 				log_err("error: invalid TFTP timeout count max\n");
 				ret = CMD_RET_FAILURE;
 				goto out;
@@ -768,11 +807,21 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 		}
 	}
 
-	if (!ipaddr_aton(server_ip, &srvip)) {
-		log_err("error: ipaddr_aton\n");
+	if (!ipaddr_aton(server_ip, &srvip) || (ipv6 && !IP_IS_V6(&srvip))) {
+		log_err("error: invalid TFTP server address\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
+#if CONFIG_IS_ENABLED(IPV6)
+	if (IP_IS_V6(&srvip)) {
+		ret = net_lwip_ip6_aton(server_ip, ip_2_ip6(&srvip));
+		if (ret || !fname || !*fname) {
+			log_err("error: IPv6 TFTP requires a unicast server address and filename\n");
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+	}
+#endif
 
 	if (fname && strlen(fname) > TFTP_MAX_FILENAME_LEN) {
 		log_err("error: TFTP file name is too long\n");
@@ -788,7 +837,8 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	}
 
 	if (!parent) {
-		if (net_lwip_start(net, NET_LWIP_ADDR_ENV_STRICT)) {
+		if (net_lwip_start(net, IP_IS_V6(&srvip) ? NET_LWIP_ADDR_ENV_FLEXIBLE :
+				   NET_LWIP_ADDR_ENV_STRICT)) {
 			ret = CMD_RET_FAILURE;
 			goto out;
 		}
@@ -797,7 +847,12 @@ static int do_tftp(int argc, char *const argv[], enum tftp_operation operation,
 	}
 
 	for (;;) {
-		ret = tftp_check_ip(net);
+#if CONFIG_IS_ENABLED(IPV6)
+		if (IP_IS_V6(&srvip))
+			ret = net_lwip_ip6_prepare(net, &srvip);
+		else
+#endif
+			ret = tftp_check_ip(net);
 		if (ret)
 			break;
 		/* Rotation may select an interface with a different IP address. */

-- 
2.53.0

