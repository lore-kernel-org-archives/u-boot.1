Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5A7D5E141
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 06:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8411088C86;
	Fri,  8 Nov 2024 07:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JZRWklT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3A888E63; Fri,  8 Nov 2024 07:42:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D3688B4B
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 07:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731048155; x=1731652955; i=xypron.glpk@gmx.de;
 bh=fiYM7ynL1SoRraAwyNG5Bdt+/S+D4lMTQ7oaov6FneY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JZRWklT9L1Z+bNdBFq4YTKS8XIJgPVi2/XBLDu2QAZ13RjwGy4bGvMPqKO44zKKB
 M2qCiDij/n4fWYn4os62Tfmr4UnUVPUmbesMwFKrx7aDQbOiQhA6AfNJXLIqKoxoX
 amGD0TO2hdJg4M0W51eISvH60/U3DBkBQvbdN/TfRXYsisqbxJB8Dw1Nds7qbyU0j
 D4ZAShdxHNuN5KRHCUzE8z1Avoryk+0N+j9wxdFr4WPTzyyjpnyV8IGCwvEQ6803y
 wn1O7yRUZk8QFaUlrpvGJG/9mavUdKOEpv20jolX/+3G+MYoLp+ymF9vgduTAWg5p
 RNgSK+l26QbSAJ0JGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.72]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRRZ-1tKbDs0Zf1-00STkb; Fri, 08
 Nov 2024 07:42:35 +0100
Date: Fri, 08 Nov 2024 07:42:26 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
CC: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_01/15=5D_net=3A_net=5Futils=3A_M?=
 =?US-ASCII?Q?ove_ip=5Fto=5Fstring_to_lib/net=5Futils=2Ec?=
User-Agent: Thunderbird for Android
In-Reply-To: <20241108034444.346164-1-adrianox@gmail.com>
References: <20241108034444.346164-1-adrianox@gmail.com>
Message-ID: <E2312DA8-B6DF-450E-8F17-8EE7CF46EE45@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U3nXKv7n+X72WSjT+TFtQhg55fOmWj64hq9snBXD7jr+/+a5LLu
 Aun3GKGqhU9zt65qM2I0Twua0f3il9aDmK2GVOrKmdyCSuo6+RDCbPmTlaiXkLWLj8thGwa
 dQWDl8Myp5Ay0L9DmfPrUqPssuon8KpnX2p60GvxY5kOE9fp/USKcYxyyPNXCOngJpUi8RT
 UKkmQzDU6hvjnqJ4+LeEw==
UI-OutboundReport: notjunk:1;M01:P0:ZAlVX7nmq84=;Gaih3hBZMiIdGPQ/GISnismLqvG
 EWrGh1iu2MKjh7XpSLdH/JVvL4BHR1ZeK9vfetZifbJ+weX3CkLfojDmD+xecLPEOhnPIPZu/
 5jIhJddQ+psr3LtdmiTe4rbpAFiL6grBUeL7w21XD9TVPv44kT3OOvjBYGIFz+/btRJCtCYSm
 bH/WC6M67HfFwvM0nuXfiGsock1kwbDOF5R8pA/Ls9f7QAIWRRK41qTCjLSRU8r/PlmJ52M5m
 hGuP+RkkZOwIrxWNysmRQk6Hmw7p4YcDdycRVcrinCTttPqQBszV6Mgg4dbTmu05qEx+b1Uey
 SnmfVILQmBKNu0h4sQt5hRthnTs9Q/1kXQyhR81F3XBAUvqGyJ06QPh7XvjM+xXZhN1bbXneN
 1d4+51azdklJ7SvS8Dp3bhSTNSb6lkIVu7glMlq+45RCeg/W+H0oyelSSkVlWP+4fTk9MzCQK
 PC+1ZHEdF9ZDvaak62No7kpoEsqAkcqSiDtBGSmyVhtuBZKOFC17ria9negAklVj6tW+GIekL
 ryQcP/Fd2crkvgJYx2tS+pPhLypEgzIqeKTbvU6iN9uu4mzhz1fmmcFeLV32U00kUOiFtzh9b
 H1ss3fGv2C2DYUOB7cdpNybq84q48WluQVukmBhtMC8Fq+4k835Ed3dr4Gc7dus0CPFpZBlxS
 IOtgHqVoX6bVfwWvNUGffioVdvysnncjht3PkHoCcIzK8OwDtkiVDLsR4xRSBRmFPYoTX0Wnc
 kvhZgTjRZI9F7jtqWaxeKp9WXqq8po9ocYhdvO9VheFuXdrdvywDzTTyW2Cre1P9SS6/1A2s0
 +tTUVtlWT+GRLSflNXIfAo4Q==
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

Am 8=2E November 2024 04:44:44 MEZ schrieb Adriano Cordova <adrianox@gmail=
=2Ecom>:
>The function string_to_ip is already in net_utils, which is
>compiled unconditionally, but ip_to_string is currently only
>accessible if the legacy network stack is selected=2E This
>commit puts ip_to_string in net_utils=2Ec and removes it from the
>legacy network code=2E
>
>Signed-off-by: Adriano Cordova <adrianox@gmail=2Ecom>

LGTM

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

Would you mind resending the series as a single email thread, please (git =
send email 0*=2Epatch or use patchman)=2E This will make reviewing and merg=
ing easier=2E


>---
> include/net-common=2Eh | 10 ++++++++++
> lib/net_utils=2Ec      | 11 +++++++++++
> net/net=2Ec            | 11 -----------
> 3 files changed, 21 insertions(+), 11 deletions(-)
>
>diff --git a/include/net-common=2Eh b/include/net-common=2Eh
>index 11c53766a3=2E=2E5206b8346d 100644
>--- a/include/net-common=2Eh
>+++ b/include/net-common=2Eh
>@@ -426,6 +426,16 @@ void string_to_enetaddr(const char *addr, uint8_t *e=
netaddr);
>  */
> struct in_addr string_to_ip(const char *s);
>=20
>+/**
>+ * ip_to_string() - Convert a string to ip address
>+ *
>+ * Implemented in lib/net_utils=2Ec (built unconditionally)
>+ *
>+ * @x: Input ip to parse
>+ * @s: string containing the parsed ip address
>+ */
>+void ip_to_string(struct in_addr x, char *s);
>+
> /* copy a filename (allow for "=2E=2E=2E" notation, limit length) */
> void copy_filename(char *dst, const char *src, int size);
>=20
>diff --git a/lib/net_utils=2Ec b/lib/net_utils=2Ec
>index c70fef0d99=2E=2E621f6512b6 100644
>--- a/lib/net_utils=2Ec
>+++ b/lib/net_utils=2Ec
>@@ -152,6 +152,17 @@ out_err:
> }
> #endif
>=20
>+void ip_to_string(struct in_addr x, char *s)
>+{
>+	x=2Es_addr =3D ntohl(x=2Es_addr);
>+	sprintf(s, "%d=2E%d=2E%d=2E%d",
>+		(int) ((x=2Es_addr >> 24) & 0xff),
>+		(int) ((x=2Es_addr >> 16) & 0xff),
>+		(int) ((x=2Es_addr >> 8) & 0xff),
>+		(int) ((x=2Es_addr >> 0) & 0xff)
>+	);
>+}
>+
> void string_to_enetaddr(const char *addr, uint8_t *enetaddr)
> {
> 	char *end;
>diff --git a/net/net=2Ec b/net/net=2Ec
>index f47e9fbe33=2E=2Eca35704f66 100644
>--- a/net/net=2Ec
>+++ b/net/net=2Ec
>@@ -1723,17 +1723,6 @@ int net_parse_bootfile(struct in_addr *ipaddr, cha=
r *filename, int max_len)
> 	return 1;
> }
>=20
>-void ip_to_string(struct in_addr x, char *s)
>-{
>-	x=2Es_addr =3D ntohl(x=2Es_addr);
>-	sprintf(s, "%d=2E%d=2E%d=2E%d",
>-		(int) ((x=2Es_addr >> 24) & 0xff),
>-		(int) ((x=2Es_addr >> 16) & 0xff),
>-		(int) ((x=2Es_addr >> 8) & 0xff),
>-		(int) ((x=2Es_addr >> 0) & 0xff)
>-	);
>-}
>-
> void vlan_to_string(ushort x, char *s)
> {
> 	x =3D ntohs(x);

