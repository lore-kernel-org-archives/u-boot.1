Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBAEC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED9DE80980;
	Tue, 25 Aug 2026 22:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5FAJtrZ5_2al; Tue, 25 Aug 2026 22:04:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787695450;
	bh=2qWXRhkLJSSkBLeD9ibrzrbWsDaWqq+Gt0r2iMPu4eU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UG2OOOV768j0YynDSmCIpNBrQbqFNLJMd3j5T/tv80RH0Sotx+U+YzOuzGWvSgYj3
	 Z6BtxrVNWRq5IJTPTNWOSMtMBp5vQY7yqTdA50iuU6EXgRgt9BGCRNWEzi/JMwBK6E
	 k5N5+fnOGfCil/QGVJdP66ueeG9hwdkPbyJOqt+BwJTWV2R+uvzGHgu7F+9CTbhVbL
	 I5yUU/SMTOKtlgzl/BggftHhsvvoJy14cUDLXbj6Y0eBuycQhLyZedX8L0tOgudyG5
	 cGhSCWZB6sSkREE8KprU34rcTsD1g+qbH10xkxcPeyG29eTwT0cYLr+33RSkGzlJpf
	 pi51Hnqb2v4Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E3B180987;
	Tue, 25 Aug 2026 22:04:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C5E1334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6A014008D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWb93D9tIzDF for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:04:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=pEmwzYEG
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7882D40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787695438; x=1788300238; i=xypron.glpk@gmx.de;
 bh=2qWXRhkLJSSkBLeD9ibrzrbWsDaWqq+Gt0r2iMPu4eU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pEmwzYEGx4/KddKV/aSEIjJcbTzh5J8xi+eNoBhhLMxIj6YvpjAWxJitodzkp5/b
 u89LBfEDO+tUwG0rECXHKdRJSP2s8ZLd6+AHp+ahJbbY4itd45wqbN2oslJN5sZcM
 yUla8Q17kTrwRJnFoTzniG39NyQ2sQ34eudmLRQuii70dUid2ktUtn6ubMZi9/wk1
 tscUu383Lc/KrWdEpTQrxQ5pMWmJd9LLcwhA5mpMUzMDyUO2l8UXDJkqM2/pT1CRx
 1kFNmTBJ7VCLOqpRR30yJ5d3itFhFWHMDvKoX3H7yScWsUVSWHtmBLOlKNahzI4Jq
 kZhQM26b/hwW7euR7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKHc-1wigqo2DqW-00vtIf; Wed, 26
 Aug 2026 00:03:58 +0200
Message-ID: <fb2519bc-b2cc-43a2-a67a-d9ad4230e9d7@gmx.de>
Date: Wed, 26 Aug 2026 00:03:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 15/45] doc: develop: sending_patches: update link to
 GPL license
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
 u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Sean Anderson
 <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-15-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-15-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Xj4++BnuxqZKNpkTBUfRfZYkoRc3fH7e8CcaRRPCBn1MQVhqJJ
 EfVVu1dtk8BVWsY0AJ77OMsAgMtacMzeMtn9WzjYW7INNGefUhe7M1X4QgrGk/ZLxJijWDM
 iRiPZf1L5/FTlj5e2Pv7TAWvpK81UIXiMRBZi3+0U1I7mxNzgcxp7c92qEw5nOkEWsSI8DB
 7Su/HBWjTFOh8XcQws8CQ==
UI-OutboundReport: notjunk:1;M01:P0:dGByS1W0oFk=;KS849tz0uKJG8h9iMYZMum8EIv3
 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
 O/50VwnkoYIZpmEu15Ek=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/25/26 18:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The link actually (after a looooooong time) redirects to the GPL-3.0
> license which isn't the appropriate license. Instead, point at the
> GPL-2.0 page.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/develop/sending_patches.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patch=
es.rst
> index 3944ca4206a0..92c34c0669d0 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -361,7 +361,7 @@ Notes
>  =20
>   1. U-Boot is Free Software that can redistributed and/or modified unde=
r the
>      terms of the `GNU General Public License
> -   <http://www.fsf.org/licensing/licenses/gpl.html>`_ (GPL). Currently =
(August
> +   <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>`_ (GPL). Cu=
rrently (August
>      2022) version 2 of the GPL applies. Please see :download:`Licensing
>      <../../Licenses/README>` for details. To allow that later versions =
of U-Boot
>      may be released under a later version of the GPL, all new code that=
 gets
>=20

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
