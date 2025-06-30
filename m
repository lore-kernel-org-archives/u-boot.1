Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252A3C8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 16:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F38E800C1;
	Mon, 30 Jun 2025 18:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="C0wquvgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B82E809A5; Mon, 30 Jun 2025 18:51:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2A48006D
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751302267; x=1751907067; i=xypron.glpk@gmx.de;
 bh=DJTkRuf+HwtpG4/N3DSnm8334MJsFjTry2OtdskixG0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=C0wquvgb2iW0FTbUUTkIdO+DL0oUh3aZrAgU8m0aeWWJurtLzFEMM3r8fbNUtRcM
 ulM9spJzUX7da5MyGFfettpPxq2K02GAG/EiNanGcXQAW+pKaHKqQIRvSoHepHpcG
 K8A1nx/Jl6qkdvrx2NbE1rhlmlCkWN3gBk50pSfyA4U0cK8sS16pad4KzGXStNlRv
 rxoO/lfHVeCF6E2eO+fxjVjRLlsdHobo5zGYGSKk+0LIsAu6jqrEIst8rekD76j3w
 mlS2Fs6LlpKDNvteJnVhL38ruYHdnDdOT3qenEwd7LPhRzwJZoZUh3Hjba8FAyyBD
 fDckepoXKOz7Po8M6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1uAXpT2GHZ-00XYc9; Mon, 30
 Jun 2025 18:51:06 +0200
Date: Mon, 30 Jun 2025 18:51:04 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_spl=3A_fit=3A_Add_ability?=
 =?US-ASCII?Q?_to_jump_to_Linux_via_OpTee-OS_on_ARMv7a?=
User-Agent: Thunderbird for Android
In-Reply-To: <c039089e-fc89-4cb9-9d98-86d0ecd11e1b@mailbox.org>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <20250630000832.952206-2-marek.vasut@mailbox.org>
 <198d53d6-bd1f-480f-86a7-5bd2987cd2a7@linaro.org>
 <c039089e-fc89-4cb9-9d98-86d0ecd11e1b@mailbox.org>
Message-ID: <A5953878-CE64-4422-BD43-644C8C5F0A2E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mTpOCzF6DUc30AnPQzWyKykXrcOZij04cHeRY+zjyoKTCJ8H9sa
 QjkiM+CCWP1sCqcuAx6nHp1BRlN3fPZa9Fw+9leeGp3MgLUoFUMe/harOUEJiN/fqaSQC9E
 ebRYmuJemycMw6Dd2SOGkfEk1OIKeJEroFwbs3wVFFP8/3RqL/FIJ/7JEF2f5rxh2rttz5i
 VfeAD2vbR+sFS0oCM8NZA==
UI-OutboundReport: notjunk:1;M01:P0:GEw2TKsyobI=;QAAyKdiiy6oD0eSLhmIwYgloo5R
 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
 vqQ/b5eM0XgpX9pbOKhcilNQVaOdeAQo=
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

Am 30=2E Juni 2025 18:22:10 MESZ schrieb Marek Vasut <marek=2Evasut@mailbox=
=2Eorg>:
>On 6/30/25 4:30 PM, Jerome Forissier wrote:
>
>Hi,
>
>> On 6/30/25 02:08, Marek Vasut wrote:
>>> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a to =
SPL=2E
>>=20
>> Nitpicking: OP-TEE OS
>Is this the official spelling ? I was always under the impression it was =
OpTee-OS =2E but maybe I am wrong=2E


OP-TEE (capital EE) or OP-TEE Trusted OS if you want to refer specifically=
 to the secure side implementation=2E See: https://optee=2Ereadthedocs=2Eio=
/en/latest/general/about=2Ehtml and https://github=2Ecom/OP-TEE/optee_os
