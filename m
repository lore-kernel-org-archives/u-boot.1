Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE7606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h8Hfw0SW;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=aOXVu2qv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F03F607B0;
	Mon,  9 Nov 2026 15:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSxbCMPYGpgV; Mon,  9 Nov 2026 15:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4CC8D607C5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794238002;
	b=Fi/6UQgXw3sKzRH/Zw0F5UV2hnRpMKKuqSI+xVDs1NYKfFmJ31Jz805S9HEQWvibpZnx
	 POnPQIB1vMdQX6o1XtazCfiGOjgDJSaJrAp2nP5tHvKzjdPXQhlvvgnGX8dhodxIStwSb
	 BvQG9YOIbeBDwUsxtlWnJc+gto6Tg/sMgz6zbosP2GTTXPq5lyPTC7sxejla7RSRENGTe
	 W9dJWMFtov/xamvjOwsYrgZ8PPyIsMSM/qlgTKvRFQetGd3YSPCLwcT6dkPv6i3HDM1fW
	 GITGdWmbMUl+2A4YvTc8Y0CLa14qN1QKLrKqLzl/bXS/cMSu1fMgIdr1CG1p7lnMbRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794238002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m7kkP/Ak3UuFFvb293Zo1i51ezk5hpn8slPIjNraHHw=;
	b=Ro9WYTqn6rpI4W51ts7+9a2EmjZnCDUjogselISur6OPlRZIcvQl4CGpOAOcWZ7Q7Hj4
	 8nQQHQu9tNqIIYGDUDWwfhZq/jAc1RVHX6k6i76DEAEHLx04/DDb64hwBA9XRrdBIEcb6
	 uvUQxqZp86/Otw39WP/xhrTQn7JGqEXuqKCN5KqEk5LXjEirgqpdDbTCrkflE8TZXwvVI
	 ZlBdDk27sRSKdqh8eKHGDiCeAtEgydFuWslHZu/zjeWL0Wvk+EACI71CpwiUe5kLYvRgr
	 aFqKbgzln0zXwQ9wFQcO/MbNqercZixktIDNuSFgUb4LYiNd10wQeSScUxj5cmDdgdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794238002;
	bh=m7kkP/Ak3UuFFvb293Zo1i51ezk5hpn8slPIjNraHHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h8Hfw0SWLCkvYCUoZmCRPQWw100KVLWH6Jv3Ef05pZpdpxO5X4Mw1ercNPFZ6ZQRf
	 JQ2Bw35G75u6fdSncYDc51ZovTCcGivAToPfZ+E3l2cA6ZGsuPB3rexVjEQ3s/Av0b
	 +R+caE756SGLhqKYpwjSQSPwUer4nnvQdLjkRzjbSNzGZONSpOjq80lu9y46FdHl66
	 Ev2Bza4kDryqh/BEchruqMKJjsCh5xzNMJbgM0VNbhGwSu3GNOt9H2vJz1BAz3IoL4
	 wL1n+Z1WMkkZTu2P8TpFeHSMzpCtjeaSKH0a+wMBsE/Trks1bCKQjUrzojtIFZFuFw
	 wOTVyCTS5V5ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CC8D607C5;
	Mon,  9 Nov 2026 15:26:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A93A932
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 600934008C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Xr24vssVop9 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1724140087
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=aOXVu2qv
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1724140087
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794237989; x=1794842789; i=xypron.glpk@gmx.de;
 bh=m7kkP/Ak3UuFFvb293Zo1i51ezk5hpn8slPIjNraHHw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aOXVu2qvV8Mw+E7bsYGe+ny3AY4jdFcIumoalFEoHbAMN75NUvRHMwt5zpPg4HEP
 RVwJdEoeeKdm8nGpi89RMxJMo/4UD9tcGvUa0nGOyAcpvTBhEHCzQTwa9QmYjSywV
 CdeUxX7udetVOHZxxpxpqc10EDTky7JwnMPO0FW+xamwgRrR+ILvkwRZsz8Nc+ttz
 oDYxNVDIgMcG6hvu09fapzldcpsbZoXsNR94qOiQwO44ZNx79cAMZvaqY3GVCdW1H
 IV2ndRmogb8V/oWuMbsBTt9KkokYnMgsoCNV4JP9xNRHo5oIlHyXSW2euNK8xwKoC
 XczuJwnUC1o1O79fXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1xCchv1eZy-00LWqj; Mon, 09
 Nov 2026 16:26:29 +0100
Message-ID: <7e4c908c-cc84-4de1-8afb-3be76f7330b4@gmx.de>
Date: Mon, 9 Nov 2026 16:26:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 02/45] doc: arch/x86: fix "link" to IRQ router DT
 binding
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-2-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-2-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sh22+s2xKeFFo+jMBCBT/BGKmeTnxEx+sYWXTzr+5FDgtP24h79
 1tRbwjx8nnZ/sVa2dq3YLdn3lE4+GuavFHoswdeGSqjPEPGuiy0nDZWJQlnl4UTBBMttwEm
 tP/uGjvA7arEj8KTu2Qguj5XP9jzCwSL5J7I8dmyBcft9j7kUHc398o4jMW9VUmOuZmCidv
 k6rzgyndytxv+y9FyN4Sg==
UI-OutboundReport: notjunk:1;M01:P0:kLgKKr/Ynmo=;Q/WMVO8jfNRupW4mZFmE6cuiy0l
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 8/25/26 18:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The device-tree binding is not part of our Sphinx docs so we cannot
> refer to it this way. Instead, follow what we've already done for other
> DT bindings and simply use the :download: role.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/arch/x86/x86.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
> index f67216d6ce02..066838b956b8 100644
> --- a/doc/arch/x86/x86.rst
> +++ b/doc/arch/x86/x86.rst
> @@ -242,7 +242,7 @@ debug serial port may be useful here. See setup_inte=
rnal_uart() for an example.
>   During the U-Boot porting, one of the important steps is to write corr=
ect PIRQ
>   routing information in the board device tree. Without it, device drive=
rs in the
>   Linux kernel won't function correctly due to interrupt is not working.=
 Please
> -refer to U-Boot `doc <doc/device-tree-bindings/misc/intel,irq-router.tx=
t>`_ for
> +refer to :download:`intel,irq-router.txt <../../device-tree-bindings/mi=
sc/intel,irq-router.txt>` for
>   the device tree bindings of Intel interrupt router. Here we have more =
details
>   on the intel,pirq-routing property below.
>  =20
>=20

Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
