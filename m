Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00447CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E1186F50;
	Sun, 15 Oct 2023 08:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UvbbaPPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D34D86F7D; Sun, 15 Oct 2023 08:53:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by phobos.denx.de (Postfix) with ESMTP id F279886FA7
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697352718; x=1697957518; i=xypron.glpk@gmx.de;
 bh=3UCku1ME1CTwbxxG6K2j6dPm/0G1unJqDI8GZan9rBw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=UvbbaPPq4Q8KKIBCYzDrTD/HShWulNzd8kbwpELwQd3j6d3cMlg6VYGBC1/x6dDGaNNUEcXT4S3
 h5QG3aUUgco/slOc6FSnb4vwInlpzJ3g+oMZcow6eZU1/oOVSWj3jnwkFen9wJD9cLlAr1PFVPQbX
 r5shw/44p/hLGaMUrqSD64SgX+Uuj8g5Mv0UIET8Il90ihXNLBl1L+exTCrACuy6fJRihstDO+Id6
 scjomjtsBK2FbGvrivMattyZFOCMYLwYoKO0T90Qi2yKIG5gJIlfDxZ9j1pCkS6rffK9I8m8uXObT
 5mom5PT1X4f8VbRlkDzHniwdFvhPkvYzIsyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1qgolE3W36-00B53K; Sat, 14
 Oct 2023 23:20:32 +0200
Date: Sat, 14 Oct 2023 23:20:31 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
CC: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2 16/29] net: bootp: Move port numbers to header
User-Agent: K-9 Mail for Android
In-Reply-To: <20231014204805.439009-17-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-17-seanga2@gmail.com>
Message-ID: <70B2C086-30BC-4CAC-B4DC-C1B7B32BB95C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X3/5dLb80JQhDVzZufaRL+BSacKfTqvfp7WvDLGvP1lnT1ihcDC
 P94XVl8xopHBeekE5YzaBk5niKERK3pjjtddmL85QS3z5cetZDqhAzYZdO1YoqvLIjTu7LJ
 HwNmPVnDMbi7+wbzcaS88evmE0j6hwKnB3rBU+4YxEZ6OzHE3kgRkdGzZWu39zOGXCWW30r
 Eh5C7yGStXdATLV088Opg==
UI-OutboundReport: notjunk:1;M01:P0:7bBe36yePqM=;nVAg1EIhVw+XXBIbUfisIfkTVKk
 7gesEoHb53bFENTSLBCXFvAVUrQdBGaQzxbYghFKsUW77Ud/cm4t6oYr3+l2mVcIrCyYXzkIl
 yjJZ7k6cv7ta+8dcFTloSHx1zfQtVE3f+69821iHCA5W54MfpgGty3za+t6PjhZiG0O8YW4B+
 ZHaEyavdRlbneoWxS3dohcQXuqXGE/KWeUxY2YjwgM5HedhGiTPnCjhBo9OQVA1W3W1fnV0LF
 44XDojHw73y8+5ykKkgNtavYKZunScaHi9Z3Q+Li0EahFdeI5IQpvcetkh3yey5AgCF9NOF+2
 R9K09s+aUZroMq6vCE8MRFpXDBCOowbvvPGtQKel8e9u0a/5YC93C+KRNnmq43Cg6Q+uDcQj+
 1HHzh4QxKVv7ExmAUbBCGD1+m5y8YrQGenq1lVyfNp+UcsZ367Hx0FsBy47kcJkUN5HjShTjs
 cOlELX2bSIWvopXRRplE24G31t/OyQRlqTtpVxfpUVJhbK6xzBbl/r+C5AQkVP3DMK6qKR/DD
 4yh9cDFlPCrJ07y2x2fJWX2YY7GCK95DFRNjijGAP1N/Sixc/mibQ2yCWtSPClghQDxcP4mVD
 209RMkPeyRWqWFsFB/MkeotGCo5FaQ3HdMCbT0XyY/h80BPf/+32QsuReDlYDerBpJ93+hOyK
 z8YIa7rVrrYZH7KcVPQMEFevbnpoUYWuWV9Fw1f98DyPRR3e3pK3EhG1sUUU5a+NtWBpI2KQU
 BA6U/sHEkHvBYxRF/pJEIAANZc+Ppk/7Ct41uGgCihowqeRkRKiSewp7DJUEPwxHiPXuAEjg1
 DwBhYtXOSUPi33h78JBvVr9Y86AIkjBGcWOgZ5lWfWcH2LEHhr/3VDpmZNehPjzy+JSSbVxWP
 AlG6TZJJtcFEAi5G5LF1h7aJg1HZn5NdfJEC+ETzxTqz5bA9P0V1MZyHRgdJE7DeqGX0w4klO
 WN4ZolA3vdMKHlJ6o2OgqjB0YDI=
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



Am 14=2E Oktober 2023 22:47:52 MESZ schrieb Sean Anderson <seanga2@gmail=
=2Ecom>:
>These defines are useful when testing bootp=2E
>
>Signed-off-by: Sean Anderson <seanga2@gmail=2Ecom>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>---
>
>(no changes since v1)
>
> net/bootp=2Ec | 3 ---
> net/bootp=2Eh | 3 +++
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/bootp=2Ec b/net/bootp=2Ec
>index 8b1a4ae2ef8=2E=2E2053cce88c6 100644
>--- a/net/bootp=2Ec
>+++ b/net/bootp=2Ec
>@@ -41,9 +41,6 @@
>  */
> #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
>=20
>-#define PORT_BOOTPS	67		/* BOOTP server UDP port */
>-#define PORT_BOOTPC	68		/* BOOTP client UDP port */
>-
> #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
> #define CFG_DHCP_MIN_EXT_LEN 64
> #endif
>diff --git a/net/bootp=2Eh b/net/bootp=2Eh
>index 567340ec5d4=2E=2E4e32b19d424 100644
>--- a/net/bootp=2Eh
>+++ b/net/bootp=2Eh
>@@ -15,6 +15,9 @@
>=20
> /**********************************************************************/
>=20
>+#define PORT_BOOTPS	67		/* BOOTP server UDP port */

Reading code I would have a hard time to immediately see what this constan=
t name stands for=2E

Shouldn't this be renamed BOOTP_SERVER_PORT to create readable code?

Regards Heinrich

>+#define PORT_BOOTPC	68		/* BOOTP client UDP port */
>+
> /*
>  *	BOOTP header=2E
>  */
