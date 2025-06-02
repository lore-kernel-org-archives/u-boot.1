Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33082C5B559
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 21:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA7B810EB;
	Mon,  2 Jun 2025 23:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QjkPr1cM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E8A81E72; Mon,  2 Jun 2025 23:13:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37FEE8006D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 23:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748898825; x=1749503625; i=xypron.glpk@gmx.de;
 bh=B3P5PDgg1fBhhTiFzZ6WJ6av1Hry5NTAfGlsae2XAKc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QjkPr1cMhg27O69l5JAzPFFLYX03/wvcZo6NDHfh4YelkeVrAi+8ULZcAzt5vK/h
 w/KVTKPA7Wj2X7YzR538OxMJsk2ijraNq7fAty07fxHNGHVNS4ps6w5K6xg4Kl821
 J1ulHETxmUR966YhR2v92VKgFA95fGh2/IqgAEeBRTjra+VrYW60BjCahUY9MQN/p
 xzQ8HON7SqQTdMMqnEEwSKxxvnzH38BdnS1bsoXOIjbRNVNC/J4WV08hFskO9u0sM
 jbd0DwH560ejabMhEhYFUoSXUSbf91/3yxAbJ90CHVvC1SA37jUDmFcpnalcq4TDR
 fH0wpoRvv0fiT4LU/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1uCbhl1usv-003nuQ; Mon, 02
 Jun 2025 23:13:44 +0200
Date: Mon, 02 Jun 2025 23:13:39 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
CC: Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/3=5D_net=3A_extract_function_?=
 =?US-ASCII?Q?net=5Fsntp=5Fset=5Frtc=28=29_from_sntp=5Fhandler=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250521151516.16729-2-jerome.forissier@linaro.org>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-2-jerome.forissier@linaro.org>
Message-ID: <EC613C0A-90A2-4F7E-A9BE-4598BEF2023E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KlhNbi/usSYMdVoFpUIAvlypS14+te/FGf5beb0XB3VIHef6NII
 7krAJdMttSMN1XptsnIW18bn5DonBfSIDZIw2uJ7VkEk1wVFfyD6nUDNo9WbQZ1+vSVSiZT
 q7Q1B+YbjZn5guCwzB6/DU5LvXzo85l3IejTlleMMd2QJ6M/7lXItiIFaUTqDmwYP7p/ROM
 WPclBIfCVICtQY+pEJruA==
UI-OutboundReport: notjunk:1;M01:P0:VOtu1UF6LVY=;rDVZ9NJnED5HmsDwayp/JIS+P6E
 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
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

Am 21=2E Mai 2025 17:14:41 MESZ schrieb Jerome Forissier <jerome=2Eforissie=
r@linaro=2Eorg>:
>Extract the code that sets the RTC clock from sntp_handler() in
>net/sntp=2Ec and make it a new function net_sntp_set_rtc() in
>net/net-common=2Ec=2E This will allow re-use with NET_LWIP=2E
>
>Signed-off-by: Jerome Forissier <jerome=2Eforissier@linaro=2Eorg>
>---
>
> include/net-common=2Eh |  2 ++
> net/net-common=2Ec     | 28 ++++++++++++++++++++++++++++
> net/sntp=2Ec           | 23 +++--------------------
> 3 files changed, 33 insertions(+), 20 deletions(-)
>
>diff --git a/include/net-common=2Eh b/include/net-common=2Eh
>index e536968a92b=2E=2Ea021bf503ff 100644
>--- a/include/net-common=2Eh
>+++ b/include/net-common=2Eh
>@@ -586,4 +586,6 @@ extern struct wget_http_info default_wget_info;
> extern struct wget_http_info *wget_info;
> int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)=
;
>=20
>+void net_sntp_set_rtc(u32 seconds);
>+
> #endif /* __NET_COMMON_H__ */
>diff --git a/net/net-common=2Ec b/net/net-common=2Ec
>index e01b0da7d7b=2E=2E30d04323d4a 100644
>--- a/net/net-common=2Ec
>+++ b/net/net-common=2Ec
>@@ -1,5 +1,9 @@
> // SPDX-License-Identifier: GPL-2=2E0
>+
>+#include <dm/uclass=2Eh>
> #include <net-common=2Eh>
>+#include <linux/time=2Eh>
>+#include <rtc=2Eh>
>=20
> void copy_filename(char *dst, const char *src, int size)
> {
>@@ -25,3 +29,27 @@ int wget_request(ulong dst_addr, char *uri, struct wge=
t_http_info *info)
> 	wget_info =3D info ? info : &default_wget_info;
> 	return wget_do_request(dst_addr, uri);
> }
>+
>+void net_sntp_set_rtc(u32 seconds)
>+{
>+	struct rtc_time tm;
>+#ifdef CONFIG_DM_RTC

Are there really RTC drivers that have not been converted to the driver mo=
del=2E If yes, shouldn't we drop these?

Best regards

Heinrich

>+	struct udevice *dev;
>+	int ret;
>+#endif
>+
>+	rtc_to_tm(seconds, &tm);
>+
>+#ifdef CONFIG_DM_RTC
>+	ret =3D uclass_get_device(UCLASS_RTC, 0, &dev);
>+	if (ret)
>+		printf("SNTP: cannot find RTC: err=3D%d\n", ret);
>+	else
>+		dm_rtc_set(dev, &tm);
>+#elif defined(CONFIG_CMD_DATE)
>+	rtc_set(&tm);
>+#endif
>+	printf("Date: %4d-%02d-%02d Time: %2d:%02d:%02d\n",
>+	       tm=2Etm_year, tm=2Etm_mon, tm=2Etm_mday,
>+	       tm=2Etm_hour, tm=2Etm_min, tm=2Etm_sec);
>+}
>diff --git a/net/sntp=2Ec b/net/sntp=2Ec
>index 73d1d87d38b=2E=2E77cee0046bd 100644
>--- a/net/sntp=2Ec
>+++ b/net/sntp=2Ec
>@@ -57,8 +57,7 @@ static void sntp_handler(uchar *pkt, unsigned dest, str=
uct in_addr sip,
> 			 unsigned src, unsigned len)
> {
> 	struct sntp_pkt_t *rpktp =3D (struct sntp_pkt_t *)pkt;
>-	struct rtc_time tm;
>-	ulong seconds;
>+	u32 seconds;
>=20
> 	debug("%s\n", __func__);
>=20
>@@ -69,24 +68,8 @@ static void sntp_handler(uchar *pkt, unsigned dest, st=
ruct in_addr sip,
> 	 * As the RTC's used in U-Boot support second resolution only
> 	 * we simply ignore the sub-second field=2E
> 	 */
>-	memcpy(&seconds, &rpktp->transmit_timestamp, sizeof(ulong));
>-
>-	rtc_to_tm(ntohl(seconds) - 2208988800UL + net_ntp_time_offset, &tm);
>-#ifdef CONFIG_DM_RTC
>-	struct udevice *dev;
>-	int ret;
>-
>-	ret =3D uclass_get_device(UCLASS_RTC, 0, &dev);
>-	if (ret)
>-		printf("SNTP: cannot find RTC: err=3D%d\n", ret);
>-	else
>-		dm_rtc_set(dev, &tm);
>-#elif defined(CONFIG_CMD_DATE)
>-	rtc_set(&tm);
>-#endif
>-	printf("Date: %4d-%02d-%02d Time: %2d:%02d:%02d\n",
>-	       tm=2Etm_year, tm=2Etm_mon, tm=2Etm_mday,
>-	       tm=2Etm_hour, tm=2Etm_min, tm=2Etm_sec);
>+	memcpy(&seconds, &rpktp->transmit_timestamp, sizeof(seconds));
>+	net_sntp_set_rtc(ntohl(seconds) - 2208988800UL + net_ntp_time_offset);
>=20
> 	net_set_state(NETLOOP_SUCCESS);
> }

