Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32377C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 05:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54FC880F0E;
	Tue,  3 Jun 2025 07:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Htv9Ew2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5D281E06; Tue,  3 Jun 2025 07:51:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088BB8091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 07:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748929894; x=1749534694; i=xypron.glpk@gmx.de;
 bh=fP+6RBhSux7rd7PAR3jGZof+s0vzt3sKTv/Ya2ypQS0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Htv9Ew2cnIrn1fwtRviF/ixS/2W7g0SgfcErMmSKa+OkN5n8kU95L6I6SD8xbAyV
 UeCt2o0TKc7Q/PoqIsbARPAwZSET9/BcWBnbhAqirqNDk3ysVSWzybq+Vf5GdnLZq
 6cUI+5C4Noh0h86/EMaA/TPyANoP7YCi67BwahtP+uvvH/rCgt4jT1W6qWShlw6Y/
 ZSt4zOT9LTuDzynrqHQ9POL0kJyN4tkZCLsT+CcXhv3NnnQkycqdY8uyxhSv66Hvq
 9MvPHFvbKWg77cO0xuNrr+2eKXC67Eo9yeV2RKMNmI3KhRkKys88JwyMshWXcuIDW
 avWrmMysDXK/cCmXmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1uhhCx3NA2-00lBt7; Tue, 03
 Jun 2025 07:51:34 +0200
Date: Tue, 03 Jun 2025 07:51:28 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
CC: Adriano Cordova <adrianox@gmail.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] net: lwip: add sntp command
User-Agent: Thunderbird for Android
In-Reply-To: <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-3-jerome.forissier@linaro.org>
 <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
Message-ID: <7714D96D-245B-4A97-B7AE-B1D669DCE1DA@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H8lF8N+R8ldMTrF7+yZqm8wi7D5laBHTogmhrgXfWTcKtzMe67M
 J0M2JmM05BHgaKDxWP/sVRrv/x4ggANIJ5SmrYHXJn8U0M1Xr1SDhn5o3Z/+YREf5bLNZ6p
 QEWp5Bl9W27N5xj1uVC3RA1bV9Ow36xj63kBon5MLwczyo2NB13hWBZ9LvCyFjH4DDVq6ON
 nbiQl8p7zY1ifwolXHCMQ==
UI-OutboundReport: notjunk:1;M01:P0:It7OdinbtPI=;TFdJp04ZXvuuFrt/E5xxTOkZxqK
 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
 EdMheDwn2gm3nVJ2QE6zlWKjidY9+PgMMnumEg==
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 2=2E Juni 2025 23:23:08 MESZ schrieb Heinrich Schuchardt <xypron=2Eglpk@=
gmx=2Ede>:
>Am 21=2E Mai 2025 17:14:42 MESZ schrieb Jerome Forissier <jerome=2Eforiss=
ier@linaro=2Eorg>:
>>Implement the sntp command when NET_LWIP=3Dy=2E

https://datatracker=2Eietf=2Eorg/doc/rfc5905/ describes that on Feb 7th, 2=
036 the 32 bit seconds field wraps around and era 1 starts=2E

Does our code consider this?

Best regards=20

Heinrich



>>
>>Signed-off-by: Jerome Forissier <jerome=2Eforissier@linaro=2Eorg>
>>---
>>
>> cmd/Kconfig                |  13 ++--
>> cmd/net-lwip=2Ec             |   5 ++
>> include/net-common=2Eh       |  11 ++++
>> lib/lwip/Makefile          |   1 +
>> lib/lwip/u-boot/arch/cc=2Eh  |   4 ++
>> lib/lwip/u-boot/lwipopts=2Eh |   4 ++
>> net/lwip/Makefile          |   1 +
>> net/lwip/sntp=2Ec            | 128 ++++++++++++++++++++++++++++++++++++=
+
>> 8 files changed, 161 insertions(+), 6 deletions(-)
>> create mode 100644 net/lwip/sntp=2Ec
>>
>>diff --git a/cmd/Kconfig b/cmd/Kconfig
>>index f21d27cb27f=2E=2E58f629e1c34 100644
>>--- a/cmd/Kconfig
>>+++ b/cmd/Kconfig
>>@@ -2061,12 +2061,6 @@ config CMD_CDP
>> 	  and to retrieve configuration data including the VLAN id using the
>> 	  proprietary Cisco Discovery Protocol (CDP)=2E
>>=20
>>-config CMD_SNTP
>>-	bool "sntp"
>>-	select PROT_UDP
>>-	help
>>-	  Synchronize RTC via network
>>-
>> config CMD_LINK_LOCAL
>> 	bool "linklocal"
>> 	depends on (LIB_RAND || LIB_HW_RAND)
>>@@ -2144,6 +2138,13 @@ config CMD_PING
>> 	help
>> 	  Send ICMP ECHO_REQUEST to network host
>>=20
>>+config CMD_SNTP
>
>The command should depend on RTC support=2E
>
>>+	bool "sntp"
>>+	select PROT_UDP if NET
>>+	select PROT_UDP_LWIP if NET_LWIP
>>+	help
>>+	  Synchronize RTC via network
>>+
>> config CMD_TFTPBOOT
>> 	bool "tftp"
>> 	select PROT_UDP_LWIP if NET_LWIP
>>diff --git a/cmd/net-lwip=2Ec b/cmd/net-lwip=2Ec
>>index cecf8d02555=2E=2E2ffee64f97e 100644
>>--- a/cmd/net-lwip=2Ec
>>+++ b/cmd/net-lwip=2Ec
>
>Please, put every command into a separate file instead of duplicating the=
 #ifdef chaos of the old network stack=2E
>
>>@@ -21,6 +21,11 @@ U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
>> 	   "[loadAddress] [[hostIPaddr:]bootfilename]");
>> #endif
>>=20
>>+#if defined(CONFIG_CMD_SNTP)
>>+U_BOOT_CMD(sntp, 2, 1, do_sntp, "synchronize RTC via network",
>>+	   "[NTP server IP]");
>>+#endif
>
>Why wouldn't we support server names ( e=2Eg=2E  0=2Ede=2Epool=2Entp=2Eor=
g) here if we have DNS enabled?
>
>Please, add the missing documentation change for the commands=2E
>
>Best regards
>
>Heinrich
>
>
>>+
>> #if defined(CONFIG_CMD_DNS)
>> U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
>> 	   "hostname [envvar]");
>>diff --git a/include/net-common=2Eh b/include/net-common=2Eh
>>index a021bf503ff=2E=2Eb06cafb497e 100644
>>--- a/include/net-common=2Eh
>>+++ b/include/net-common=2Eh
>>@@ -505,6 +505,17 @@ int dhcp_run(ulong addr, const char *fname, bool au=
toload);
>>  */
>> int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
>>=20
>>+/**
>>+ * do_sntp - Run the sntp command
>>+ *
>>+ * @cmdtp: Unused
>>+ * @flag: Command flags (CMD_FLAG_=2E=2E=2E)
>>+ * @argc: Number of arguments
>>+ * @argv: List of arguments
>>+ * Return: result (see enum command_ret_t)
>>+ */
>>+int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
>>+
>> /**
>>  * do_tftpb - Run the tftpboot command
>>  *
>>diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
>>index e9e8caee93a=2E=2Ec3f0e916f66 100644
>>--- a/lib/lwip/Makefile
>>+++ b/lib/lwip/Makefile
>>@@ -13,6 +13,7 @@ obj-y +=3D \
>> 	lwip/src/api/sockets=2Eo \
>> 	lwip/src/api/tcpip=2Eo \
>> 	lwip/src/apps/http/http_client=2Eo \
>>+	lwip/src/apps/sntp/sntp=2Eo \
>> 	lwip/src/apps/tftp/tftp=2Eo \
>> 	lwip/src/core/altcp_alloc=2Eo \
>> 	lwip/src/core/altcp=2Eo \
>>diff --git a/lib/lwip/u-boot/arch/cc=2Eh b/lib/lwip/u-boot/arch/cc=2Eh
>>index 6104c296f6f=2E=2Ef91127ac565 100644
>>--- a/lib/lwip/u-boot/arch/cc=2Eh
>>+++ b/lib/lwip/u-boot/arch/cc=2Eh
>>@@ -43,4 +43,8 @@
>> #define BYTE_ORDER BIG_ENDIAN
>> #endif
>>=20
>>+#define SNTP_STARTUP_DELAY 0
>>+void sntp_set_system_time(uint32_t sec);
>>+#define SNTP_SET_SYSTEM_TIME(sec) sntp_set_system_time(sec)
>>+
>> #endif /* LWIP_ARCH_CC_H */
>>diff --git a/lib/lwip/u-boot/lwipopts=2Eh b/lib/lwip/u-boot/lwipopts=2Eh
>>index edac74ff7a2=2E=2E14ba7bd7ae2 100644
>>--- a/lib/lwip/u-boot/lwipopts=2Eh
>>+++ b/lib/lwip/u-boot/lwipopts=2Eh
>>@@ -162,4 +162,8 @@
>> #define LWIP_ALTCP_TLS_MBEDTLS          1
>> #endif
>>=20
>>+#if defined(CONFIG_CMD_SNTP)
>>+#define LWIP_DHCP_GET_NTP_SRV 1
>>+#endif
>>+
>> #endif /* LWIP_UBOOT_LWIPOPTS_H */
>>diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>>index 5df222589b8=2E=2E5bb98dc4d98 100644
>>--- a/net/lwip/Makefile
>>+++ b/net/lwip/Makefile
>>@@ -4,6 +4,7 @@ obj-$(CONFIG_$(PHASE_)DM_ETH) +=3D net-lwip=2Eo
>> obj-$(CONFIG_CMD_DHCP) +=3D dhcp=2Eo
>> obj-$(CONFIG_CMD_DNS) +=3D dns=2Eo
>> obj-$(CONFIG_CMD_PING) +=3D ping=2Eo
>>+obj-$(CONFIG_CMD_SNTP) +=3D sntp=2Eo
>> obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp=2Eo
>> obj-$(CONFIG_WGET) +=3D wget=2Eo
>>=20
>>diff --git a/net/lwip/sntp=2Ec b/net/lwip/sntp=2Ec
>>new file mode 100644
>>index 00000000000=2E=2E3b2bc3c679d
>>--- /dev/null
>>+++ b/net/lwip/sntp=2Ec
>>@@ -0,0 +1,128 @@
>>+// SPDX-License-Identifier: GPL-2=2E0+
>>+/* Copyright (C) 2025 Linaro Ltd=2E */
>>+
>>+#include <command=2Eh>
>>+#include <console=2Eh>
>>+#include <dm/device=2Eh>
>>+#include <lwip/apps/sntp=2Eh>
>>+#include <lwip/timeouts=2Eh>
>>+#include <net=2Eh>
>>+
>>+#define SNTP_TIMEOUT 10000
>>+
>>+static enum done_state {
>>+	NOT_DONE =3D 0,
>>+	SUCCESS,
>>+	ABORTED,
>>+	TIMED_OUT
>>+} sntp_state;
>>+
>>+static void no_response(void *arg)
>>+{
>>+	sntp_state =3D TIMED_OUT;
>>+}
>>+
>>+/* Called by lwIP via the SNTP_SET_SYSTEM_TIME() macro */
>>+void sntp_set_system_time(uint32_t seconds)
>>+{
>>+	char *toff;
>>+	int net_ntp_time_offset =3D 0;
>>+
>>+	toff =3D env_get("timeoffset");
>>+	if (toff)
>>+		net_ntp_time_offset =3D simple_strtol(toff, NULL, 10);
>>+
>>+	net_sntp_set_rtc(seconds + net_ntp_time_offset);
>>+	sntp_state =3D SUCCESS;
>>+}
>>+
>>+static bool ntp_server_known(void)
>>+{
>>+	int i;
>>+
>>+	for (i =3D 0; i < SNTP_MAX_SERVERS; i++) {
>>+		const ip_addr_t *ip =3D sntp_getserver(i);
>>+
>>+		if (ip && ip->addr)
>>+			return true;
>>+	}
>>+
>>+	return false;
>>+}
>>+
>>+static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>>+{
>>+	struct netif *netif;
>>+
>>+	netif =3D net_lwip_new_netif(udev);
>>+	if (!netif)
>>+		return -1;
>>+
>>+	sntp_state =3D NOT_DONE;
>>+
>>+	sntp_setoperatingmode(SNTP_OPMODE_POLL);
>>+	sntp_servermode_dhcp(CONFIG_IS_ENABLED(CMD_DHCP));
>>+	if (srvip) {
>>+		sntp_setserver(0, srvip);
>>+	} else {
>>+		if (!ntp_server_known()) {
>>+			log_err("error: ntpserverip not set\n");
>>+			return -1;
>>+		}
>>+	}
>>+	sntp_init();
>>+
>>+	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
>>+	while (sntp_state =3D=3D NOT_DONE) {
>>+		net_lwip_rx(udev, netif);
>>+		sys_check_timeouts();
>>+		if (ctrlc()) {
>>+			printf("\nAbort\n");
>>+			sntp_state =3D ABORTED;
>>+			break;
>>+		}
>>+	}
>>+	sys_untimeout(no_response, NULL);
>>+
>>+	sntp_stop();
>>+	net_lwip_remove_netif(netif);
>>+
>>+	if (sntp_state =3D=3D SUCCESS)
>>+		return 0;
>>+
>>+	return -1;
>>+}
>>+
>>+int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[])
>>+{
>>+	ip_addr_t *srvip =3D NULL;
>>+	char *server_ip =3D NULL;
>>+	ip_addr_t ipaddr;
>>+
>>+	switch (argc) {
>>+	case 1:
>>+		server_ip =3D env_get("ntpserverip");
>>+		break;
>>+	case 2:
>>+		server_ip =3D argv[1];
>>+		break;
>>+	default:
>>+		return CMD_RET_USAGE;
>>+	}
>>+
>>+	if (server_ip) {
>>+		if (!ipaddr_aton(server_ip, &ipaddr)) {
>>+			log_err("error: ipaddr_aton\n");
>>+			return CMD_RET_FAILURE;
>>+		}
>>+		srvip =3D &ipaddr;
>>+	}
>>+
>>+	if (net_lwip_eth_start() < 0)
>>+		return CMD_RET_FAILURE;
>>+
>>+	if (sntp_loop(eth_get_dev(), srvip) < 0)
>>+		return CMD_RET_FAILURE;
>>+
>>+	return CMD_RET_SUCCESS;
>>+}
>

