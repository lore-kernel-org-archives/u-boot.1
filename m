Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C3FC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 21:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB6C810EB;
	Mon,  2 Jun 2025 23:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PEQAMgAe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D2881E72; Mon,  2 Jun 2025 23:23:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B275C80BAE
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 23:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748899393; x=1749504193; i=xypron.glpk@gmx.de;
 bh=nTZMtOosn3oTG9Cc0VhAE5U6CQQVycjS+mGrL3tjiig=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PEQAMgAerL1q7QoU/EuTADadvfWXABLC5H0yW6u73qxETkdhXyxro6PGUJNcSAIE
 6BedSaiJvVeGTtc/IYjwz94T+3Wa9yaua6zdQMGPwI/pAonFlrqsfItje1DQzF3To
 6h2e3VKjNjYZoTGBdBEvmy+9b9b7HbViMvE1r4IwNM6YHteRu6iQ8Not2dvR+3rhG
 NOnl+V14D/RH0fa1Hs2jvepUzvcvgJzkrC7vEpkVTfghh71sViSYeQGdYzybaaPd2
 Kux2JkV+gfn529Q58SS6VPinM+MMovBkK+Ix7jxBXTaMm+bxL10mfnwLJ1w1hHESH
 hkceYA9QdLLnuLCuBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1ulfYS2rG0-00joeu; Mon, 02
 Jun 2025 23:23:12 +0200
Date: Mon, 02 Jun 2025 23:23:08 +0200
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
In-Reply-To: <20250521151516.16729-3-jerome.forissier@linaro.org>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-3-jerome.forissier@linaro.org>
Message-ID: <C092D71D-1A30-44D5-8043-07EE04DA571B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYU3xcw9JzNAR3KafXRPLOzRbyrgyznhZUtysUCHLfqPkJTr0kW
 iRa1tY/2kFbCdP6J/DMA3wZER12tHRXIESkzZMo/MzHpcAAgGdcC455p1zGFlo9mNTnYaER
 yLn5LPx3rWPVwCs04Mnnq2E5C3weKp1kd3IpM5xIM+cCYFN5WwYdX0mGU2RXgnClMy+P7+1
 62e/uQOCGWWkXgHPOLSXw==
UI-OutboundReport: notjunk:1;M01:P0:o6F9Yx6ZSsU=;A6yveJCJEXoZNeE7F5gl4MhRBLs
 f1bdY98NiwGIj1KyTtU5S2jCY7BGQtiR+0QkVLyIjfPZAuk6E8l6l7R+l+8n/tmQkoed+oKmf
 wDPxot+cz8NV+uDxOlFCwqcIB9nVqMlLdGLGxMyVqMwuTfQQng7D/N6J4KqJ9KKc1S5ZVaHHS
 XRt3wn7xBkznmRcFnXpvALJ5lS7J5hTdEeV280ITaYWv/5CqZSG9NEwo+o8G5QWECB+49hBmH
 6wfNNhcc5B1HIBvAXngbH/7RMMcZfFfki5S5rHK4lFMJiPhOXtw7h3rZtiL/+BQKt3oiChmod
 Jbn+7HNymJB0C1egvLBaUV5avdJoovxpI7hJL7Iyqr6PFdR+0rwK/WXnnTI9xN4oKSxfobMh8
 sahyRvbLsBIiz6JsWGXIse1QbMzN4o4irYjWE+KeSwUUavRDq3ctpX7VDtOcpo5RKuyhzgpcq
 Yo0ffZfOxCNMN7bj7yJtVhtA7UHq/A4pdNxjoA/3t8BSpEN8xEO8jCYUcofpA6kXiY/jPS64V
 1k0U7trlLrsutZ7/vB4D2W+WRRW5c9kAU7n/w1h9HKBO6b8WOCa8Nf4pgl06YBoIF6+dTPVxG
 Kk0HD57W4bhYXVbXKduwPZ1DyuxKFUEnIeWvdtfVhsIuf0htzHmc088jaw0jGIgPKK4WnJJy7
 sW4z0I0T0MqOIcyzBO/uZ2hnqe/yV5FN9EdgD9GP8h9pC2UzCEDzblQC2pRG80iS3euY0FRJ/
 cyYnl9oSWjGaKrmNOfDUtolJiO7yNi5KfDxscYhsaVqk7sS2+5kJKb2TNFIvRBT0OsSR4G2GV
 QSOIcqYcq+FFUMek7euOp//YEcqgqWAsTCVyQ94VUh0MxzPi9XmqgTjIrcBP3DcoQ4nCmriSI
 7XEnRjznQ9A9R0wCPvQAiw9J2eIWCvOZxqNeUPyhZET5A/fMVXHBKEwhCd1KtWbyptpx8JgKv
 rIw8slAETfE81mwGdwqZ0ih8yKYklJGN3/6KNvBkhVhcUqOuXhukcTIu3ThuSC+0RtowFfrPh
 Hz0AoT+AHj7+COqZsYAsKtR6EVFM3UsnySG9fTW5UYTGDBrIXCe1GMrKTRcXlri1UWS09YuMQ
 5FlFR3KGFxtgDSpsPOefGTly2lgHYG+3oVNCxozfJYPIsiVgcgwoxxRjsvoAOaXTrDJ2RWAt7
 N/Bve3IV0qeESZ8f307GQnB8Cw/kKxO9/u8VxChIujgNbvcvvdziMonlNifNlDae+zC00jges
 F2yXL52XDA4iXDkn4kurVPvA9Cf6nwv8gH1MXBdgWVye4DSidgkZ/nKRj6//2T0JNhPJs/FZ1
 pdeORvkxJvJ26GB8vhcPR+SKKaq60h7AU0PVyRiOtJXoA83vPbTiIxBhEmC99TOswd/bnKten
 UTXb+bDRfVL+1eLIAP8HvEG5HkJlrL/ZbTwNjktXoY6cok+E/VxXjLgJ+Bwihg1REpilCvx92
 oaa6/+piDi6Y5Rln08XU7OvHJghZnALGO+0LE0ZpBawJTTu5mHAnmpbbvp4Ml1Usmg/iu92Zu
 W4wEcBTpgRdohNEoXVcRlb4kR1hmQKeNQ+ZqebF2i/yUXS4+ghFoo/0AO6lJBT8TRhnm2OzNw
 9wIrQ9aKLoCUjmaORpPuRm3SEn9aHK2ff1oKRc3j0gpqIZ2Ta66Ee3W49EpQkjGh2KYpAgZbv
 InQlNR+wi7yx4HEo+BAiw6TNMGVi+uSMYKlZWFijdtK9jt7rWjq0AXSfvw+h/6PqfqTdzE9Cv
 6yBrshB2LrIj0M96UBZgkIWvVBUYFE6aT5t74dx4GmeoxcP2aDJFmE43oQxP401F5rEMyvKJF
 8Yp7+2D//ivbTKZApdq0fravL3c8p02rlSy5DvIG6fodtrA2DWaJ1QImlXYmItE4yLR9dlwh7
 8/2xHvEDCx4rm229YHoCprBJkDX4b0Cx8zGaWFmU5vWDMSkDu0AyYxL6XJWtVXXuEIHFCUozG
 BvfVf2K9ZFb5P8qJxaXiBMDJiGCk+EUJVwFwx2M67e5vGx1Zoyh/rQHr9DCjViKR3dEShvugY
 6+ZhYaZ8U4kseJ8xU0ASrTFd9UAEHdMfbu+9SIJTG1w44qqRgBtVWd/XtDYL8gV1VFd+76YVf
 tVUwNRv52x0JpZhIZQ+/BaTEU+RA5ejfSlU1xySLBXj2N8adF4hnJ/icmYvK2xeodQLNvqu98
 bHXaBth28Brl09ZHgwnDLX8rswHWwN+DlloFEcFK5doOIC2+Huxa5903QoM5Dh4nYj00x8wwS
 iJbtunXz2g/poG6q3qFK0lljInIovS2W6B4skhFkSGay4UJovo9/Ub0olfxxqEXVknjc6OM41
 quyt3xM9GHHG9SCaZ1a09h7nJoujBmH6vUMUCaWBMIfjbAQg3kgUmuiHGV5p41lUd6Cpk+ky2
 jm1GQv2ERFaF4TK25t2wbFKImGMTQZpKtjYBpuCgUvcGoXXgLhVWz+ojcUAx0Ag8okOXc0PAg
 1jSjZVy0ZISL124rD5eIZzWjzTgy12d9+pdGPeUFqmxn4ikyCODvGhfen6EYUjilxK5eFRJmP
 wC9SXKe5WEL7O9m69ePSvFR9nPN3i/B8MpaZdbZxSyGU+/Vs/6r7c58XaMYldnI/3Xm9tmVMo
 LvvpBnm1/Nv4W9r6PymU0Smy+PMnPF7ElDIrCNwgZYNwFKdkMjjIskGFUcMJAWK3emxBOG9u4
 8/a6hv5K74bDNIR5VsFgVlg29JiduytfhJn4YMR+PomGGwnlCyWlwcwauedNWhYdUXaBJump4
 nVJgEwi4xxkv9SBxBHfofO1eOx6i1+DzgGa/Jq6tt/fQoqYznycJWGolmfmjQ9uD5X0OVOCcX
 KYOA/BC2dBo0bQQBmIoY5WU0olV5o21xnOBb8Y1ebCG3vC54mg6ntebA33q+m8OdH7L0nDa5p
 rAoQ/S1Nzi6iBO9+J95TKEoCf578xXYmQcvC7L7lh7MPls4pObsZ3LeyzoFyXgnb3GLnnKr2K
 RSzBdv13J7wMsuECybkSfCNWThvRQLKYcn2eH+39hW3gqJUp8HZLFdm/toEwR7IZlDdz3BwJD
 UI64LqSTd7b9Ypveb+GLv09CcPx6vhHNHcBKf96MwC8pNHmRYQim9HjyZ7xcCL2krysNjMX2k
 nWdO1jaE/brknpMHWbZifF2kZ6WC0AIFsMNdQ8vLT+x6ITqOIi7oU58pc3F8sjfoCLnPHPnU3
 LRujYccSLQoQ7rgF2Llc7xKVj3jdR+s1jHEjr7hhQKpfHupJg7EiJuXTDEJR/kvDKNokKwI5F
 gpy4Aft5zCaHMMpV
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

Am 21=2E Mai 2025 17:14:42 MESZ schrieb Jerome Forissier <jerome=2Eforissie=
r@linaro=2Eorg>:
>Implement the sntp command when NET_LWIP=3Dy=2E
>
>Signed-off-by: Jerome Forissier <jerome=2Eforissier@linaro=2Eorg>
>---
>
> cmd/Kconfig                |  13 ++--
> cmd/net-lwip=2Ec             |   5 ++
> include/net-common=2Eh       |  11 ++++
> lib/lwip/Makefile          |   1 +
> lib/lwip/u-boot/arch/cc=2Eh  |   4 ++
> lib/lwip/u-boot/lwipopts=2Eh |   4 ++
> net/lwip/Makefile          |   1 +
> net/lwip/sntp=2Ec            | 128 +++++++++++++++++++++++++++++++++++++
> 8 files changed, 161 insertions(+), 6 deletions(-)
> create mode 100644 net/lwip/sntp=2Ec
>
>diff --git a/cmd/Kconfig b/cmd/Kconfig
>index f21d27cb27f=2E=2E58f629e1c34 100644
>--- a/cmd/Kconfig
>+++ b/cmd/Kconfig
>@@ -2061,12 +2061,6 @@ config CMD_CDP
> 	  and to retrieve configuration data including the VLAN id using the
> 	  proprietary Cisco Discovery Protocol (CDP)=2E
>=20
>-config CMD_SNTP
>-	bool "sntp"
>-	select PROT_UDP
>-	help
>-	  Synchronize RTC via network
>-
> config CMD_LINK_LOCAL
> 	bool "linklocal"
> 	depends on (LIB_RAND || LIB_HW_RAND)
>@@ -2144,6 +2138,13 @@ config CMD_PING
> 	help
> 	  Send ICMP ECHO_REQUEST to network host
>=20
>+config CMD_SNTP

The command should depend on RTC support=2E

>+	bool "sntp"
>+	select PROT_UDP if NET
>+	select PROT_UDP_LWIP if NET_LWIP
>+	help
>+	  Synchronize RTC via network
>+
> config CMD_TFTPBOOT
> 	bool "tftp"
> 	select PROT_UDP_LWIP if NET_LWIP
>diff --git a/cmd/net-lwip=2Ec b/cmd/net-lwip=2Ec
>index cecf8d02555=2E=2E2ffee64f97e 100644
>--- a/cmd/net-lwip=2Ec
>+++ b/cmd/net-lwip=2Ec

Please, put every command into a separate file instead of duplicating the =
#ifdef chaos of the old network stack=2E

>@@ -21,6 +21,11 @@ U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
> 	   "[loadAddress] [[hostIPaddr:]bootfilename]");
> #endif
>=20
>+#if defined(CONFIG_CMD_SNTP)
>+U_BOOT_CMD(sntp, 2, 1, do_sntp, "synchronize RTC via network",
>+	   "[NTP server IP]");
>+#endif

Why wouldn't we support server names ( e=2Eg=2E  0=2Ede=2Epool=2Entp=2Eorg=
) here if we have DNS enabled?

Please, add the missing documentation change for the commands=2E

Best regards

Heinrich


>+
> #if defined(CONFIG_CMD_DNS)
> U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
> 	   "hostname [envvar]");
>diff --git a/include/net-common=2Eh b/include/net-common=2Eh
>index a021bf503ff=2E=2Eb06cafb497e 100644
>--- a/include/net-common=2Eh
>+++ b/include/net-common=2Eh
>@@ -505,6 +505,17 @@ int dhcp_run(ulong addr, const char *fname, bool aut=
oload);
>  */
> int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
]);
>=20
>+/**
>+ * do_sntp - Run the sntp command
>+ *
>+ * @cmdtp: Unused
>+ * @flag: Command flags (CMD_FLAG_=2E=2E=2E)
>+ * @argc: Number of arguments
>+ * @argv: List of arguments
>+ * Return: result (see enum command_ret_t)
>+ */
>+int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
]);
>+
> /**
>  * do_tftpb - Run the tftpboot command
>  *
>diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
>index e9e8caee93a=2E=2Ec3f0e916f66 100644
>--- a/lib/lwip/Makefile
>+++ b/lib/lwip/Makefile
>@@ -13,6 +13,7 @@ obj-y +=3D \
> 	lwip/src/api/sockets=2Eo \
> 	lwip/src/api/tcpip=2Eo \
> 	lwip/src/apps/http/http_client=2Eo \
>+	lwip/src/apps/sntp/sntp=2Eo \
> 	lwip/src/apps/tftp/tftp=2Eo \
> 	lwip/src/core/altcp_alloc=2Eo \
> 	lwip/src/core/altcp=2Eo \
>diff --git a/lib/lwip/u-boot/arch/cc=2Eh b/lib/lwip/u-boot/arch/cc=2Eh
>index 6104c296f6f=2E=2Ef91127ac565 100644
>--- a/lib/lwip/u-boot/arch/cc=2Eh
>+++ b/lib/lwip/u-boot/arch/cc=2Eh
>@@ -43,4 +43,8 @@
> #define BYTE_ORDER BIG_ENDIAN
> #endif
>=20
>+#define SNTP_STARTUP_DELAY 0
>+void sntp_set_system_time(uint32_t sec);
>+#define SNTP_SET_SYSTEM_TIME(sec) sntp_set_system_time(sec)
>+
> #endif /* LWIP_ARCH_CC_H */
>diff --git a/lib/lwip/u-boot/lwipopts=2Eh b/lib/lwip/u-boot/lwipopts=2Eh
>index edac74ff7a2=2E=2E14ba7bd7ae2 100644
>--- a/lib/lwip/u-boot/lwipopts=2Eh
>+++ b/lib/lwip/u-boot/lwipopts=2Eh
>@@ -162,4 +162,8 @@
> #define LWIP_ALTCP_TLS_MBEDTLS          1
> #endif
>=20
>+#if defined(CONFIG_CMD_SNTP)
>+#define LWIP_DHCP_GET_NTP_SRV 1
>+#endif
>+
> #endif /* LWIP_UBOOT_LWIPOPTS_H */
>diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>index 5df222589b8=2E=2E5bb98dc4d98 100644
>--- a/net/lwip/Makefile
>+++ b/net/lwip/Makefile
>@@ -4,6 +4,7 @@ obj-$(CONFIG_$(PHASE_)DM_ETH) +=3D net-lwip=2Eo
> obj-$(CONFIG_CMD_DHCP) +=3D dhcp=2Eo
> obj-$(CONFIG_CMD_DNS) +=3D dns=2Eo
> obj-$(CONFIG_CMD_PING) +=3D ping=2Eo
>+obj-$(CONFIG_CMD_SNTP) +=3D sntp=2Eo
> obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp=2Eo
> obj-$(CONFIG_WGET) +=3D wget=2Eo
>=20
>diff --git a/net/lwip/sntp=2Ec b/net/lwip/sntp=2Ec
>new file mode 100644
>index 00000000000=2E=2E3b2bc3c679d
>--- /dev/null
>+++ b/net/lwip/sntp=2Ec
>@@ -0,0 +1,128 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/* Copyright (C) 2025 Linaro Ltd=2E */
>+
>+#include <command=2Eh>
>+#include <console=2Eh>
>+#include <dm/device=2Eh>
>+#include <lwip/apps/sntp=2Eh>
>+#include <lwip/timeouts=2Eh>
>+#include <net=2Eh>
>+
>+#define SNTP_TIMEOUT 10000
>+
>+static enum done_state {
>+	NOT_DONE =3D 0,
>+	SUCCESS,
>+	ABORTED,
>+	TIMED_OUT
>+} sntp_state;
>+
>+static void no_response(void *arg)
>+{
>+	sntp_state =3D TIMED_OUT;
>+}
>+
>+/* Called by lwIP via the SNTP_SET_SYSTEM_TIME() macro */
>+void sntp_set_system_time(uint32_t seconds)
>+{
>+	char *toff;
>+	int net_ntp_time_offset =3D 0;
>+
>+	toff =3D env_get("timeoffset");
>+	if (toff)
>+		net_ntp_time_offset =3D simple_strtol(toff, NULL, 10);
>+
>+	net_sntp_set_rtc(seconds + net_ntp_time_offset);
>+	sntp_state =3D SUCCESS;
>+}
>+
>+static bool ntp_server_known(void)
>+{
>+	int i;
>+
>+	for (i =3D 0; i < SNTP_MAX_SERVERS; i++) {
>+		const ip_addr_t *ip =3D sntp_getserver(i);
>+
>+		if (ip && ip->addr)
>+			return true;
>+	}
>+
>+	return false;
>+}
>+
>+static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>+{
>+	struct netif *netif;
>+
>+	netif =3D net_lwip_new_netif(udev);
>+	if (!netif)
>+		return -1;
>+
>+	sntp_state =3D NOT_DONE;
>+
>+	sntp_setoperatingmode(SNTP_OPMODE_POLL);
>+	sntp_servermode_dhcp(CONFIG_IS_ENABLED(CMD_DHCP));
>+	if (srvip) {
>+		sntp_setserver(0, srvip);
>+	} else {
>+		if (!ntp_server_known()) {
>+			log_err("error: ntpserverip not set\n");
>+			return -1;
>+		}
>+	}
>+	sntp_init();
>+
>+	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
>+	while (sntp_state =3D=3D NOT_DONE) {
>+		net_lwip_rx(udev, netif);
>+		sys_check_timeouts();
>+		if (ctrlc()) {
>+			printf("\nAbort\n");
>+			sntp_state =3D ABORTED;
>+			break;
>+		}
>+	}
>+	sys_untimeout(no_response, NULL);
>+
>+	sntp_stop();
>+	net_lwip_remove_netif(netif);
>+
>+	if (sntp_state =3D=3D SUCCESS)
>+		return 0;
>+
>+	return -1;
>+}
>+
>+int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[=
])
>+{
>+	ip_addr_t *srvip =3D NULL;
>+	char *server_ip =3D NULL;
>+	ip_addr_t ipaddr;
>+
>+	switch (argc) {
>+	case 1:
>+		server_ip =3D env_get("ntpserverip");
>+		break;
>+	case 2:
>+		server_ip =3D argv[1];
>+		break;
>+	default:
>+		return CMD_RET_USAGE;
>+	}
>+
>+	if (server_ip) {
>+		if (!ipaddr_aton(server_ip, &ipaddr)) {
>+			log_err("error: ipaddr_aton\n");
>+			return CMD_RET_FAILURE;
>+		}
>+		srvip =3D &ipaddr;
>+	}
>+
>+	if (net_lwip_eth_start() < 0)
>+		return CMD_RET_FAILURE;
>+
>+	if (sntp_loop(eth_get_dev(), srvip) < 0)
>+		return CMD_RET_FAILURE;
>+
>+	return CMD_RET_SUCCESS;
>+}

