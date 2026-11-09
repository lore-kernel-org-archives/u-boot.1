Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5E606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Bhk6kMW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CxGkJWuw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3277B80D50;
	Mon,  9 Nov 2026 08:14:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E5ySNMyX84sk; Mon,  9 Nov 2026 08:14:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 484A780E22
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794212060;
	b=ovyn5ZcQvc11MTBVYgjMiczZMQGLsmw2zM7wIoZ/6sl5iQyffsMsNgpjBfzWDHMmk1hn
	 ae7JjoSyqPXOGPwlplD3yBKTSN2o6B0J3mFz//Q36HpRe+5ldE/Ju1Z4/dkDgeszVRREF
	 ChZrRMMrADlmbsmhRjcFl/KCgPseYIm47pfFvZJvPPlEoBDq5utXg5K/IgylJRL/l/tSG
	 9qJvFZiZvE3NidWW08XfIWTGyZdxOiYPCuMIwdSFMQ6aEtQ02erxTDoxB9rGgzjtu1vby
	 7idp8d6Yf+s3ezrhzxRkrvNLZtFQrLvRNUFbqcsKyfnlq3LyUaY0RPV3uGxHSO2SnVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794212060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cML2Ohlo4KQ/YwJAD0KdT8yTo5N/0VcuGsNCGETTEf8=;
	b=HwaqGWU71Bjv6gOuhDuuY+plfefVeyHvAKCcZARpxSdxc4uVMAS07aGKOBURkSaDTRwh
	 BDU9C8PJq1uTE9K+6HhZqHUzhLzK6BLrtCZfpcOe1Prc8xFgUSPEh2EGeXE1FSHolWDZp
	 tXEkt6UZjYkf8L1/0Ixx0cK27fMy5PH/lP4NjrTPkxfS4n544awPAYeuKOS+xahkSZJQw
	 TFeNdLDBG5QQ9LDkLSfD1qJ5IB908B4LJyt/JVS2aiYmOx7mqSG82kFxJOPryrk6kfva/
	 6tcKW7mOGgthtwpzYwos5S9Y278kH80glRIpA7aczJtKLihPVEpmPWnmpd6oMB1WcqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794212060;
	bh=cML2Ohlo4KQ/YwJAD0KdT8yTo5N/0VcuGsNCGETTEf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Bhk6kMW5LRUh9Gn+t9T0C0CgmHJb3SikgCq4eHgeagABW+JC9r7YaHnZMIuFCjAU
	 bNs7ZSTikfFRx+416ljJarjAr9d8lf/TsD0I82fAhlrMBmEaWgtmvD4iVohxzoYRn3
	 rZ5iSqk7jWgBUJgVKTJ6wRJrmIR7OF5ONiauAuf7tLnMh1qON8Jo6h6Hsnncn/3Zjc
	 UI0umK8VO3GyWJZpyFtEyUYwbaRbkX5fJyG9673Rg8GOTwe8kylIUdeN5FL1/IvqWD
	 Tceh8GzXWuHDEBdJZHWYmfkJ2ri6+dWeKUAIKvsYhOHoIucb+fuFchvaRqbMjmEUhd
	 h8xeekLZ+m2Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 484A780E22;
	Mon,  9 Nov 2026 08:14:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18504111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0522E40242
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YHP5Ai15VdNc for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1C1744022F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CxGkJWuw
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C1744022F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:14:14 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6b19e291cc6so484520eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794212053; x=1794816853;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cML2Ohlo4KQ/YwJAD0KdT8yTo5N/0VcuGsNCGETTEf8=;
 b=CxGkJWuwTlLyT1tEGfkmrm8sdxuEox/uSTAknUScKgWcFZZMUYS+TbZ/I4mzYrb9ky
 sZkcXX0YSCGg7kJXiQxwGNztPzVYk4ONBKaTYb61v5vwibNPQOFlsFYJDyEhPmcVa4jt
 t1z9W03EvvGJRoMZYO1DlmUVnGxYKiXsM04nkFrKC+NE+BdM4Bg85zqDXYzWWLMsqzKJ
 xZVK1bsjdoCANiHni7Sh58b4IOP2eS50hb81tmLzxof7tLRUq7bcgloNIjJARvWSlJni
 nOdDqy+ClQATpzHo0wD1AhQHna1BAERtcI1PSPy6iTYfRyde6AuwGOHn1DyKOgoqYGIm
 Z8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794212053; x=1794816853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cML2Ohlo4KQ/YwJAD0KdT8yTo5N/0VcuGsNCGETTEf8=;
 b=XM7IiZIvtkGjtq6hrqpddXDWxbE5jzV+JvhPbEbAo9NAfcw/+e/lYL9ywM5n1aFc/U
 gHc+HVxoYMF5I3uyKdK3QZ4vhYjvnlrd6LdTnZYSJiyXlDUvdN1SUWIVxuxW67ZnwKya
 Sr5NwYC3rIZxIwyCJsZF4hjJrDXWAGhwMRmIgTtypmPfkpaJAaMPGjBraULs+H4YmO4D
 ei8uVXYqqQ0OU3Hu3l4DEBicM22PHPYGkfQY6Sjkjt3QzoAxnlRiA4L36Cx+f5306zbC
 VO0BOORLa251hGKmEWOT7YNQ+btFQvqlqCDko3KwgASBo1ull31Vy4YuWI6uklz+qbLZ
 W9FA==
X-Gm-Message-State: APuU4Z9ym8k4iZGdO398I579KDzRpfagZ6dZYaVWyPUAJx7cduJ++jgF
 FOAMkx06EZJEt4SuW1IgmZ5wXo+5831WCOPlNQ1ACpecBkHc06ckteFJJhUJqK3c
X-Gm-Gg: AYBFou1NpB2ddpTDYeiheUY5ugTYQ6stoCQVjcqB89unpWn71TCBk6zzo1I7+2ayC75
 /dT75DMBiQQYd7YSQVfRyx+Ms2M8k/YsdTi4o8cR3d0zpm+AyY48ydaXeEumeBA8G9PhG8LhCBy
 T/4/Y8qcACgBN2i0OEX7J1PDoiE9uRgFiRef60KWyP+YUN66haziXR6KRPRKSAw5qxPyMQ+IXRh
 3m3qNo2fRGfBl5JC8rzu4ItNCOxccXcVmfZR/MIbbF3vWAE7fNN46WbFMKKPXcGlVKEDb51i8gE
 G0CMLO5MPNyl6VItQ+I3bvjtPXRKjlZ1KB3Tl5CkFOgiafR5LYyDU/OlRKwZcQVP5ShhHY2d5Bp
 8ISZ6psxr2QFbwduQj5z4pBMnlIgF+ImCPo5f4PCvbhhuxuHRqWFlyjoET3bmrO3ee7/Gni7Zh3
 fI84CtwBn0E+AxNE5R6PqkjXGz+GJ+cikGjryCvVeC5l8lH6LtFTlbXooe1u5P7ukomRQv5O17c
 78jy4eb0W7JbGOpW4THo3Lfz+rgq2gOs7V6HE18ivl+JKcdjmipUtqS1KuKivMtCwhxdHfqPCif
 ZH1xcAE5WL8a0X5rU0b1csb/M4Fc6f87mQqgLFDmR7VUUZy5BPBEs2pKXsvqwLtwbSwuH1BLYE1
 eef6VPq2O33urQ2nU0HuRQpi85BaODQFaeCZXpVqcoQHRBMCWxlgjJX2yaQLdbuSGX1Uh99Gp/z
 4SgnKVi1BKCxBxx+1nk5BTq//VkoDJf+VClvxwItwzgstqOx3mMVI=
X-Received: by 2002:a05:6820:169e:b0:70a:1787:2698 with SMTP id
 006d021491bc7-7170f252b58mr1673766eaf.36.1794212053549; 
 Mon, 09 Nov 2026 00:14:13 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8cbcb9sm2816766eaf.6.2026.11.09.00.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:14:12 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 01:14:09 -0700
Subject: [PATCH 2/3] net: lwip: support the wol command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-lwip-wol-v1-v1-2-d11961f7666f@gmail.com>
References: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
In-Reply-To: <20261109-submit-lwip-wol-v1-v1-0-d11961f7666f@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the existing wol command with lwIP and listen through the shared
network runtime. Recognize Ethernet magic packets and unfragmented IPv4
UDP packets on ports 0, 7 and 9, without requiring an IP address or a DHCP
exchange.

Observe frames before normal lwIP delivery so port zero does not become
an ephemeral UDP bind and unconfigured interfaces can receive magic
packets. Check IP and UDP lengths and checksums before examining the
payload. Leave unrelated traffic and the interface lifetime available
to other clients.

Preserve Ethernet-only password export and zero-timeout waits. Remove
the listener on success, timeout, receive failure and Ctrl-C so later
commands cannot complete an old wait.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig         |  11 +++--
 include/net/wol.h   |   5 ++
 net/lwip/Makefile   |   1 +
 net/lwip/net-lwip.c |   4 ++
 net/lwip/wol.c      | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 51adc0846c8..e1df9ade23b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2213,11 +2213,6 @@ config IPV6_ROUTER_DISCOVERY
 	  Will automatically perform router solicitation on first IPv6
 	  network operation
 
-config CMD_WOL
-	bool "wol"
-	help
-	  Wait for wake-on-lan Magic Packet
-
 endif  # if NET_LEGACY
 
 config CMD_TFTPPUT
@@ -2258,6 +2253,12 @@ config CMD_ETHSW
 	  operations such as enabling / disabling a port and
 	  viewing/maintaining the filtering database (FDB)
 
+config CMD_WOL
+	bool "wol"
+	help
+	  Wait for a Wake-on-LAN magic packet on the active Ethernet interface.
+	  Accept Ethernet packets and IPv4 UDP packets on ports 0, 7 and 9.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/include/net/wol.h b/include/net/wol.h
index c604c000045..623f8ff71b8 100644
--- a/include/net/wol.h
+++ b/include/net/wol.h
@@ -40,6 +40,11 @@ void wol_save_password(const void *packet, unsigned int len);
 /* Wait for a magic packet; a zero timeout waits until interrupted. */
 int wol_wait(ulong timeout);
 
+struct netif;
+
+/* Observe Ethernet input without taking ownership of the receive buffer. */
+void net_lwip_wol_receive(struct netif *netif, const u8 *packet, int len);
+
 /*
  * Initialize wol (beginning of netloop)
  */
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index d010a62fa65..3491c9d88b2 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PROT_ICMP_LWIP) += icmp_unreach.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
+obj-$(CONFIG_CMD_WOL) += wol.o
 
 ifeq (y,$(CONFIG_WGET_BUILTIN_CACERT))
 $(obj)/builtin_cacert.c: $(CONFIG_WGET_BUILTIN_CACERT_PATH:"%"=%) FORCE
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 60fcf9b3225..6bb07ee6888 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -22,6 +22,7 @@
 #include <lwip/timeouts.h>
 #include <net.h>
 #include <net/pcap.h>
+#include <net/wol.h>
 #include <timer.h>
 #include <time.h>
 #include <u-boot/schedule.h>
@@ -647,6 +648,9 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 					       packet, len, true);
 			}
 
+			if (IS_ENABLED(CONFIG_CMD_WOL))
+				net_lwip_wol_receive(netif, packet, len);
+
 			pbuf = alloc_pbuf_and_copy(packet, len);
 			if (pbuf)
 				netif->input(pbuf, netif);
diff --git a/net/lwip/wol.c b/net/lwip/wol.c
new file mode 100644
index 00000000000..579f9752d50
--- /dev/null
+++ b/net/lwip/wol.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <console.h>
+#include <net.h>
+#include <net/wol.h>
+#include <time.h>
+#include <asm/unaligned.h>
+#include <lwip/inet_chksum.h>
+#include <lwip/prot/ip4.h>
+#include <lwip/prot/udp.h>
+
+static struct netif *wol_netif;
+static bool wol_received;
+
+static void wol_receive_udp(struct netif *netif, const u8 *packet, unsigned int len)
+{
+	struct ip_hdr ip;
+	struct udp_hdr udp;
+	ip4_addr_t src, dst;
+	unsigned int hlen, iplen, udplen;
+	struct pbuf p = {};
+	u16 port;
+
+	if (len < sizeof(ip))
+		return;
+	memcpy(&ip, packet, sizeof(ip));
+	hlen = IPH_HL_BYTES(&ip);
+	iplen = ntohs(IPH_LEN(&ip));
+	if (IPH_V(&ip) != 4 || hlen < sizeof(ip) || iplen > len ||
+	    iplen < hlen + sizeof(udp) || IPH_PROTO(&ip) != IPPROTO_UDP)
+		return;
+	/* Do not mistake a fragment's payload for a UDP header or magic packet. */
+	if (IPH_OFFSET(&ip) & htons(IP_OFFMASK | IP_MF))
+		return;
+	if (inet_chksum(packet, hlen))
+		return;
+
+	ip4_addr_copy(src, ip.src);
+	ip4_addr_copy(dst, ip.dest);
+	if (!ip4_addr_isany_val(*netif_ip4_addr(netif)) &&
+	    !ip4_addr_eq(&dst, netif_ip4_addr(netif)) &&
+	    !ip4_addr_isbroadcast(&dst, netif))
+		return;
+
+	packet += hlen;
+	memcpy(&udp, packet, sizeof(udp));
+	port = ntohs(udp.dest);
+	udplen = ntohs(udp.len);
+	if ((port != 0 && port != 7 && port != 9) ||
+	    udplen < sizeof(udp) || udplen > iplen - hlen)
+		return;
+
+	/* A read-only pbuf view lets lwIP verify the complete UDP checksum. */
+	p.payload = (void *)packet;
+	p.len = udplen;
+	p.tot_len = udplen;
+	if (udp.chksum && inet_chksum_pseudo(&p, IPPROTO_UDP, udplen, &src, &dst))
+		return;
+
+	/* As in the legacy command, only Ethernet packets export a password. */
+	wol_received = wol_check_magic(packet + sizeof(udp), udplen - sizeof(udp),
+				       netif->hwaddr);
+}
+
+void net_lwip_wol_receive(struct netif *netif, const u8 *packet, int len)
+{
+	u16 protocol;
+
+	if (netif != wol_netif || wol_received || len < ETHER_HDR_SIZE)
+		return;
+	protocol = get_unaligned_be16(packet + 2 * ARP_HLEN);
+	packet += ETHER_HDR_SIZE;
+	len -= ETHER_HDR_SIZE;
+
+	switch (protocol) {
+	case PROT_WOL:
+		if (wol_check_magic(packet, len, netif->hwaddr)) {
+			wol_save_password(packet, len);
+			wol_received = true;
+		}
+		break;
+	case PROT_IP:
+		wol_receive_udp(netif, packet, len);
+		break;
+	}
+}
+
+int wol_wait(ulong timeout)
+{
+	struct net_lwip_ctx net = {};
+	ulong start;
+	int ret;
+
+	if (wol_netif)
+		return -EBUSY;
+
+	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_FLEXIBLE);
+	if (ret)
+		return ret;
+
+	/*
+	 * Observe Ethernet input: WoL also works without an IP address and on
+	 * UDP port zero, which udp_bind() reserves for ephemeral port selection.
+	 * Other runtime clients continue to receive their packets normally.
+	 */
+	wol_netif = net.netif;
+	wol_received = false;
+	start = get_timer(0);
+	while (!wol_received) {
+		if (ctrlc()) {
+			puts("\nAbort\n");
+			ret = -EINTR;
+			break;
+		}
+		if (timeout && get_timer(start) >= timeout) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		ret = net_lwip_poll();
+		if (ret < 0)
+			break;
+	}
+	if (wol_received)
+		ret = 0;
+	wol_netif = NULL;
+	net_lwip_stop(&net);
+
+	return ret;
+}

-- 
2.53.0

