Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07A7C83F32
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A495B86682;
	Thu, 31 Aug 2023 14:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WYgeDWdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C5E78652C; Thu, 31 Aug 2023 10:42:39 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01898654A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
Received: from [IPV6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820] (unknown
 [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E68A6607299;
 Thu, 31 Aug 2023 09:42:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1693471356;
 bh=Y3OS+OG//Q27jVbPPqX7Z65mqBcbEFupgVz6ZLv1eDg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WYgeDWdHHzcB3YyFExWYV2ScNEhNcnPsUXcSzhOl+3QSYQeFRTJeiZsxjFRUFA4jh
 PGPs2uuOtBzBuFVfZU338n5zKhenGr2yg4qCy4ftn7JQPWCII/OVkUe69KpsjaI8DX
 nOhz52qPORgIeDzxUGVvHcsmzBcLHBWYt5RTFPFga318o4JjllszzFhnOMlbPZo99j
 plmLg8Zz47sHn7V3IFjBvw615ukWtdoluvX5B2En/+JiwKtkODgfh09YyTmS+RyiLJ
 pTfwQvVNXrvwyrvpaKT56W1dbUobHD9UvcyBCSJI+cEbs2DLwjNhsWlbPFqo6i7zGb
 saA31SlFaoZpg==
Message-ID: <e15ddd5c-c91c-80cc-9031-0eff97708e9c@collabora.com>
Date: Thu, 31 Aug 2023 09:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 02/32] spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, "Andrew F. Davis" <afd@ti.com>,
 Aswath Govindraju <a-govindraju@ti.com>, Breno Lima <breno.lima@nxp.com>,
 Dave Gerlach <d-gerlach@ti.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Green Wan <green.wan@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, Le Jin
 <le.jin@siemens.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Walle <michael@walle.cc>, Michal Simek <michal.simek@amd.com>,
 Navin Sankar Velliangiri <navin@linumiz.com>, Niel Fourie <lusus@denx.de>,
 Patrick Wildt <patrick@blueri.se>, =?UTF-8?Q?Pawe=c5=82_Anikiel?=
 <pan@semihalf.com>, Peng Fan <peng.fan@nxp.com>,
 Siew Chin Lim <elly.siew.chin.lim@intel.com>,
 Silvio Fricke <open-source@softing.de>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-3-sjg@chromium.org>
Content-Language: en-US
From: Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <20230830180524.315916-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

Hi,

On 30/08/2023 19:04, Simon Glass wrote:
> We like to put the SPL first so it is clear that it relates to SPL. Rename
> various malloc-related options which have crept in, to stick to this
> convention.
>
> Signed-off-by: Simon Glass<sjg@chromium.org>

For the common changes and `configs/am335x_guardian_defconfig`:

Reviewed-by: Martyn Welch <martyn.welch@collabora.com>


Martyn

