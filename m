Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5054EFF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A0C803C6;
	Fri,  1 May 2026 09:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hamYDEdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C8883A91; Fri,  1 May 2026 09:56:58 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D205180086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 569F260142;
 Fri,  1 May 2026 07:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87334C2BCB4;
 Fri,  1 May 2026 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777622214;
 bh=/jsow83Kos95Z9IZgZ30pnayvcHp/71GJNpIioAiqhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hamYDEdvKIIlQc89zedNgX5gO+yIfK3ToOIf96wyIEFSkE6nR6tQPJCGsCkvjtPBY
 QBgDxV86BvYFnevpu8uMn/2wutxXcAXRFyQ9QOYrkbAiXPwGwJi8rk9FM/Wp3PVc2x
 sAcyRoFYhnDXcrBU2cYrgpI9Pt7ZPrxg/L8/k/0JT3VaSUkjEKEu/vyBOKuFi7374q
 NvVE/UrIN3gHgVV8g2f5ZjU3AgkK2DM2SG1i0Y1ue/mpP311lIWLN86dH/ALFBCerO
 19SVXrdvQV5u2N/sSYF7H/kpVUTmQaldiKUU1mlpGcMPCyId9+r7GJk2WPRgmlom0k
 +RkeIoAOk/KVw==
Date: Fri, 1 May 2026 13:26:42 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v3 0/5] Add partition type GUID support for environment
Message-ID: <afRcurpPhg4BAgP0@sumit-xelite>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <aeYsA_UOFIg0BZOx@sumit-xelite>
 <cd81616a-0d04-4a3e-93a2-b8ab35093ea7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd81616a-0d04-4a3e-93a2-b8ab35093ea7@oss.qualcomm.com>
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

On Mon, Apr 27, 2026 at 10:19:30PM +0530, Balaji Selvanathan wrote:
> 
> On 4/20/2026 7:07 PM, Sumit Garg wrote:
> > On Sun, Apr 19, 2026 at 03:54:02PM +0530, Balaji Selvanathan wrote:
> > > This series adds support for locating partitions using GPT partition
> > > type GUID instead of unique partition UUID. This enables the saveenv
> > > command to work with partitions identified by their type rather than
> > > unique identifiers, providing flexibility for systems where partition
> > > UUIDs may vary across devices but types remain constant.
> > Why don't we rather rely on partition name/label instead? That can be
> > common across platforms too. I would rather prefer a config fragment for
> > eg. UFS based environment or eMMC based environment and so on.
> > 
> > -Sumit
> 
> Hi Sumit,
> 
> Using type GUIDs as they offer following advantages: they are standardized
> across vendors (e.g., ChromeOS kernel GUID, Linux filesystem GUID) unlike
> arbitrary partition names that vary by OEM or firmware version, they are
> immutable and set at partition creation, making them more robust than
> easily-modified partition names.
> 

That's fair, let's at least document the partition name used for
environment in the defconfig such that it's easier for users to know
that.

-Sumit

> 
> > 
> > > Patch 1 adds part_get_info_by_type_guid() function support
> > > Patch 2 adds scsi_get_blk_by_type_guid() function support
> > > Patch 3 adds support for partition type GUID based environment
> > > Patch 4 enables partition type GUID configs for QCM6490 and QCS615
> > > Patch 5 adds unit test for the partition type GUID lookup functionality
> > > 
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > > ---
> > > Changes in v3:
> > > - Addressed minor corrections in Patch 1 in part_get_info_by_type_guid function
> > > - Refactor env_scsi_get_part and env_scsi_load functions based
> > >    on the choice configs in Patch 3
> > > - Add unit test for the partition type GUID lookup functionality in Patch 5
> > > - Link to v2: https://lore.kernel.org/u-boot/20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com/
> > > 
> > > Changes in v2:
> > > - Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
> > > - Introduce a Kconfig choice config to select between UUID-based
> > > and type GUID-based partition lookup methods.
> > > - Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
> > > - Link to v1: https://lore.kernel.org/u-boot/20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com/
> > > 
> > > ---
> > > Balaji Selvanathan (5):
> > >        disk: Add partition lookup by type GUID functionality
> > >        scsi: Add partition lookup by type GUID for SCSI devices
> > >        env: scsi: Add support for partition type GUID based environment
> > >        configs: Enable partition type GUID for QCM6490 and QCS615 boards
> > >        test: dm: Add partition type GUID lookup test
> > > 
> > >   configs/qcm6490_defconfig     |  5 +++++
> > >   configs/qcom_qcs615_defconfig |  5 +++++
> > >   disk/part.c                   | 37 +++++++++++++++++++++++++++++++
> > >   drivers/scsi/scsi-uclass.c    | 28 ++++++++++++++++++++++--
> > >   env/Kconfig                   | 51 ++++++++++++++++++++++++++++++++++++-------
> > >   env/scsi.c                    | 45 +++++++++++++++++++++++---------------
> > >   include/part.h                | 21 ++++++++++++++++++
> > >   include/scsi.h                | 11 ++++++++++
> > >   test/dm/part.c                | 48 ++++++++++++++++++++++++++++++++++++++++
> > >   9 files changed, 223 insertions(+), 28 deletions(-)
> > > ---
> > > base-commit: e3405917a1806971d9e72a94186b299f05581e1a
> > > change-id: 20260419-type-c6a48a1c273d
> > > 
> > > Best regards,
> > > -- 
> > > Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > > 
