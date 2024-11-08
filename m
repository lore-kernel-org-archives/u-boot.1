Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A20D5E141
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 06:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2F788D70;
	Fri,  8 Nov 2024 07:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uRz6UQt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A975A88DFA; Fri,  8 Nov 2024 07:59:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DA488B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 07:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731049154; x=1731653954; i=xypron.glpk@gmx.de;
 bh=hwzgKFeIQ45Gm215+ZI01P4hqAay2qA+/WF7HprtlgI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uRz6UQt777swF0/uCQjj6hkyMDh1Hi6ozyErZIUgG/SU5YgL9TSjWjMzvxPHp+9d
 gNAnZZTogdcA4xPNONe5nklUAHDbYOCvX1CryihKB4yxddC3qa0Qb4ov23P0qvUtg
 WF/Qfr4Ct+n+9Qk+TP3CSyUyc+hyHESCrpTRXtDPFI12bQdMi1skG8XaRqq8z5lxw
 XPnGPGAfXAEFL9Kh9Xz9UB39v7h62+jOqfm13cGaR5P0nVnB7fJ/pQ3BCdS+FIIOD
 sCpGmorlI1sVCbdS8u0kXAvLS/Sns0dkCJqWRyUOBymlbCOkDK08KMToAczvTmEmb
 JKUk5NNpWQuJjZ81hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.72]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1tI8eH43pQ-00MKVB; Fri, 08
 Nov 2024 07:59:14 +0100
Date: Fri, 08 Nov 2024 07:59:10 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
CC: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH 02/15] net: wget: let wget_with_dns work with dns disabled
User-Agent: Thunderbird for Android
In-Reply-To: <20241108034501.346196-1-adrianox@gmail.com>
References: <20241108034501.346196-1-adrianox@gmail.com>
Message-ID: <24794EED-5826-40C1-94F7-BA50160BD61D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgElDECJ5VJADSd1ahjwNOTNnleh6931OSnPL7Ksd4lOvmWKj78
 COCkCiPI19e8jGr8AOMD+skahY2/9SuAp02xtxRlDNQtcebbKkl/Lpj+W6Dld69oLyt/IWG
 +qnzaIckRwBL15Q0XCnNdYEQWEMIwMjrVD9IvFFYIwBkUuOMaVNtQOVoXKpkhHXM7/ND00N
 1F3c1Cqj6J7EPp/drLzjg==
UI-OutboundReport: notjunk:1;M01:P0:0V733ud38e4=;24QBLcM/bnFQ9h8lMy04aeDMHDa
 9uHCaE1yJke1GQUsvQ3329Q1v4F81GAo9vKADBsC+AegTnUwFSd2NjYmrdql+yhwmPC8nr5E8
 Nav/Z7ldYc9fcmAtwNn6vADLhhFPidSdRt9TqNlSDfZMjeF9xoOlJGMrXecFm52pUcS+xVEXZ
 0uobH5mbHmi7zvaRzoHCfjQZmURPZSt7JQInA6Pe/FQNUVrKJJKvvHdXhCQVv3KVo1KsNNqwp
 rO0TrkrRAhepOT5bnjABVvmXxHJNRR1kjtM1JYIDAs3yyCbstCyBj7W/TYwdgE/yK7YGKN4hB
 iYyAksvXNTFnsfHORhcvpRfrpGaI2kui2bcaImg7yv2IWbSurHTMq4ytE9Q/d5UDKKghcH4JU
 AUP4mimjnPKW34tEq8PRD/aqDhDaGE3+RGRgLL593W29QQFWzVjeV6EI6wv5dngNDqO92hESv
 nKUBfDFr7wfQncwGct8krxmxI8UiYES/53dhG+l+3BjkyLwvwXn9GHXuzG1VdSe9BM5JHWjQl
 HW8YJd7oQhNrfQMHOVOzPuOSMaQyxq7i3N8GN2PktlOV9dTIA/DDFe/ovh0xfIpB6O+UYzigO
 HUu29pFlJ5jt+JNDB6WGOQb3/s9Ilu2W3diEL9hFlpJAbscNiMGrThEoahjVgcZhqvWzstnSO
 HL97wd5UJSbsKFSjjnKmMQ73jK1mA6ZKvmXpqM1Q9TBaW/Gu4PK+dVj3yKn8HCXUGyE9cwcO7
 ZudKLwXLblNSa7aVQQ3mxdECqY6JUVSoqdmHrInJRUvi9sC1BYo97q0YmmCwo/Cfz/17GVom1
 NntUb15VLYR/aEYyOkqLZ/aQ==
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

Am 8=2E November 2024 04:45:01 MEZ schrieb Adriano Cordova <adrianox@gmail=
=2Ecom>:
>This was marked as TODO in the code:
>-Enable use of wget_with_dns even if CMD_DNS is disabled if
>the given uri has the ip address for the http server=2E
>-Check for port in the uri when transforming to legacy wget
>syntax inside wget_with_dns=2E
>-Move the check for CMD_DNS inside wget_with_dns=2E
>
>Signed-off-by: Adriano Cordova <adrianox@gmail=2Ecom>
>---
> net/wget=2Ec | 38 ++++++++++++++++++++++++--------------
> 1 file changed, 24 insertions(+), 14 deletions(-)
>
>diff --git a/net/wget=2Ec b/net/wget=2Ec
>index 2d931c2bc6=2E=2E5bb61a2b8d 100644
>--- a/net/wget=2Ec
>+++ b/net/wget=2Ec
>@@ -528,12 +528,10 @@ void wget_start(void)
> 	wget_send(TCP_SYN, 0, 0, 0);
> }
>=20
>-#if (IS_ENABLED(CONFIG_CMD_DNS))
> int wget_with_dns(ulong dst_addr, char *uri)
> {
> 	int ret;
>-	char *s, *host_name, *file_name, *str_copy;
>-
>+	char *s, *host_name, *file_name, *str_copy, *port;
> 	/*
> 	 * Download file using wget=2E
> 	 *
>@@ -554,18 +552,31 @@ int wget_with_dns(ulong dst_addr, char *uri)
> 	}
> 	file_name =3D s;
>=20
>-	/* TODO: If the given uri has ip address for the http server, skip dns =
*/
>-	net_dns_resolve =3D host_name;
>-	net_dns_env_var =3D "httpserverip";
>-	if (net_loop(DNS) < 0) {
>-		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resol=
ve);
>-		ret =3D -EINVAL;
>-		goto out;
>-	}
>-	s =3D env_get("httpserverip");
>-	if (!s) {
>+	port =3D host_name;
>+	host_name =3D strsep(&port, ":");
>+
>+	if (string_to_ip(host_name)=2Es_addr !=3D 0) {
>+		s =3D host_name;
>+	} else {
>+#if (IS_ENABLED(CONFIG_CMD_DNS))

The U-Boot project prefers to use 'if' instead of #if' (if it compiles)=2E=
 This allows the compiler to check both paths for syntax and then eliminate=
 the unused one=2E We are using the -O2 optimization setting=2E

If you run scripts/checkpatch=2Epl, you will see a warning=2E

>+		net_dns_resolve =3D host_name;
>+		net_dns_env_var =3D "httpserverip";
>+		if (net_loop(DNS) < 0) {
>+			log_err("Error: dns lookup of %s failed, check setup\n", net_dns_reso=
lve);
>+			ret =3D -EINVAL;
>+			goto out;
>+		}
>+		s =3D env_get("httpserverip");
>+		if (!s) {
>+			log_err("Error:  %s could not be resolved\n", net_dns_resolve);
>+			ret =3D -EINVAL;
>+			goto out;
>+		}
>+#else
>+		log_err("Error: dns disabled, %s could not be resolved\n", host_name);

I would tend to remove "Error:" in all messages as it provides no addition=
al information=2E

Best regards

Heinrich

> 		ret =3D -EINVAL;
> 		goto out;
>+#endif
> 	}
>=20
> 	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
>@@ -579,7 +590,6 @@ out:
>=20
> 	return ret < 0 ? ret : 0;
> }
>-#endif
>=20
> /**
>  * wget_validate_uri() - validate the uri for wget

