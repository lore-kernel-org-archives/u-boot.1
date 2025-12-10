Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ABDD3C545
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 12:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 623CB83759;
	Wed, 10 Dec 2025 13:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZMBH4IAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86A98389A; Wed, 10 Dec 2025 13:55:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76678367F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1765371327; x=1765976127; i=xypron.glpk@gmx.de;
 bh=eITvZzq+hyzGZnfm/ipKzE1Hb8lA+q+vrQbMkIipou8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZMBH4IAuL27ZA/LVDmYPOP++eKd9JVFY2iePlnODs/o49IgHJ28HxSt09+vGLiEM
 voNApiqOEHFhZiaFWxC8gDcFh7lNqD9Kph6+CDLcB9NdWbuGdG0rY8T2EMmrvVuaP
 SP2LsxmOGNwW+aRgEatZBZSCtexKQWWb6kaRDKGQ6PqoRSYuhZAE6BxUQyIvynO8a
 fuLjWP/iIehciKNoPIN6ZjVWw38rDNmIkPY589uaoae84Vz0a51QLmlfYAUcP0szl
 ukT3hZb2NTd5J+A3Z0wC2GU/DgCmYPHBlIIpywjLIRLkInXerO1GqmaTRSqFDDer+
 R/3hAa/Ta0yn9aR7dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.125] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1vL2Fh0qLy-004BMv; Wed, 10
 Dec 2025 13:55:27 +0100
Message-ID: <d9abea30-3604-4c06-9ec0-15e67edf34f7@gmx.de>
Date: Wed, 10 Dec 2025 13:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: Port NFS to LWIP
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Is1U3dal3P8pwHd6v0pTOPszj/nhXCvRCjxzrk/rk8KFhUcmHrX
 g6oZWLv40FQfIw1ipctScW4ZbvkYEEXJVc0k9KepZdel1W5tq3uAho009ILFBEiocbNBOHX
 +Mnb38lvn7ZR+IzhD6IOc8J2f9FYV9tGxLZYNIys/KTGi4QNtmWcxHnh5N6zjJEB8mwkEt3
 wVfbznRKTPjbji150ALuw==
UI-OutboundReport: notjunk:1;M01:P0:IGbakJOeV40=;gKvsaSx18/tlRt68ORlrZ39fh/Z
 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
 tiVde9Bg=
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

On 12/8/25 13:52, Andrew Goodbody wrote:
> This series ports the existing NFS code so that it can be used with both
> the legacy network code and also with LWIP.
> Firstly some legacy network code, mostly variables, is moved into common
> files so that it is accessible to LWIP.
> Secondly the NFS code is refactored so that the parts that are not
> specific to the network code can be shared with both network
> implementations.
> Finally the LWIP specific parts needed to interface the NFS shared code
> to that network stack are added and enabled.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Andrew Goodbody (5):
>        net: move net_state to net-common
>        net: Move some variables to net-common files
>        net: nfs: Add licence header
>        net: nfs: Move most NFS code to common files
>        net: lwip: nfs: Port the NFS code to work with LWIP
>=20
>   cmd/Kconfig          |  28 +-
>   cmd/lwip/Makefile    |   1 +
>   cmd/lwip/nfs.c       |  11 +
>   include/net-common.h |  38 ++-
>   include/net-legacy.h |  26 --
>   include/net-lwip.h   |   1 +
>   net/Makefile         |   1 +
>   net/lwip/Makefile    |   1 +
>   net/lwip/net-lwip.c  |   5 -
>   net/lwip/nfs.c       | 282 +++++++++++++++++
>   net/net-common.c     |  21 ++
>   net/net.c            |  23 --
>   net/nfs-common.c     | 863 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>   net/nfs-common.h     | 123 ++++++++
>   net/nfs.c            | 849 +------------------------------------------=
=2D------
>   net/nfs.h            |  59 ----
>   16 files changed, 1368 insertions(+), 964 deletions(-)
> ---
> base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
> change-id: 20251029-lwip_nfs-5385efca71bc
>=20
> Best regards,

Thank you for looking into the LWIP port.

We lack an NFS server in our Gitlab CI to run the NFS test.

For HTTP we are running
python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}"
in .gitlab-ci.yml.

We should do something similar for NFS.

There is a userspace NFS server available
at https://github.com/unfs3/unfs3.

This worked on my workstation:

cat > exports << EOF
/home/ubuntu
EOF
./unfsd -e `pwd`/exports  -u  -n 4096 -m 4096
sudo mount -t nfs \
-o port=3D4096,mountport=3D4096,mountvers=3D3,nolock \
localhost:/home/ubuntu /mnt

Now in /mnt I could see the /home/ubuntu file-system.

With LWIP we should think about enabling tcp for NFS.

Best regards

Heinrich
