Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A003CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1A6140684;
	Mon,  5 Oct 2026 05:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rH3Qf8sc_yNO; Mon,  5 Oct 2026 05:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2340E4058A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177171;
	b=DIHf2LtXmUZN9NMdq7WqLNaP+pTxQU81vTUU0lP0LmjxT3AHkSGB7RuabVUHe1dv60FR
	 /MMCGOexY429rJLJBkqYy9Anx1RkcW/Gh9rNGSaObRIg0lFPLzpzLfgbQTOcFMztZu4M6
	 6ClgiAj595jI0n8Q0cBYw4ihnMi3wl1ViBEEp3TnCZRK/Nc/zu0MQH8hkPGXQ7EremNSF
	 8+wNW+69/ecWH5ckE78NSJdzC+ZG7X4/DZbDmJji1u2wIvJf73ZLnNUcx4qT8WbTTJElM
	 OuFWbgKMoByGxx/Ut4tcASE8KFQB9xRDqfY5arwUjxmwurYyFyNUhMZvTXzQxqmPKPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Sd8UmzEdOztef5FY3Hr1AQz1hE9+rn9FLppfYMb+1/0=;
	b=IhVlVZF4/NuGWzHiCwXOJCbm8/j1N4BRe6GCX028e5PiM4MT4Mr6XNGLTDbB9Y5XdDPA
	 TL6Q72i8bUGzw7QwQCEEFsKkHydsTTbmZsfo1doimsSXD3m9txIEgLJmeFZgs/U4JlddS
	 i4eYI00xXgxGJ+sKk+y11B6DeqDKSUEYcs/V10LBWAty/WUlhXxaJYnJGXI2brlgPiLj4
	 R8J1IU7T0F0rrPivoMYn/UX55Kxme0MRpktWybiN/VtSw+3NdQuVEJBZuq2JcgILL0WJv
	 RqtTqGfBGeFmVc1oxE8UzA5p4fytxYnFQ7tLkwcOOK0Ms+AG5pEVNff7yEpl9GrWyxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RpCHlrAZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177171;
	bh=Sd8UmzEdOztef5FY3Hr1AQz1hE9+rn9FLppfYMb+1/0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=cH+ctq21KThM60Dv0RdHshaQCTdu53c+omhyClsnXZ+IH6NoqtjXN67xuzAzs32qa
	 9LLtdJrt+O11bXk8z47gVjWhLp9vr/A7z3/su+QToBvBosuVd+tVW+TfDnegwj2Fml
	 uDYlsJ096R5wdLLBMJb4TU6yK5PanckDrno9BrXMwIEr6M0HHf9ku275kIAumjUWDP
	 3guErYUs1nBlXuE4yATGh5vRujKZBYNYmUMivgpI2ihupOhSFRDHynkgBl4f9Y/4zO
	 uEwHXl4Z8S9VNwr2thSjQFCD/b5pcvN6bJFCjEGC2/rFDTY5SJtz5fh89vLx3jkAqG
	 2FhrXihw6ngWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2340E4058A;
	Mon,  5 Oct 2026 05:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EC0722B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2507B4040B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGGrNNWCTf0x for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 36D58403FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141783;
 b=e2nxrYesjZXvnZdyLSGYO7bBeWls2kve4ZS/DZxQNW1dpUoctMeb8kIJ9OZG4Nr7BHRH
 j9xBmA3z5lsOK2rVY1jOCanOgXTQwtbSKUTNcl6UgHHja1dYo+bl4NwYfYctBxA1H5dhH
 dVIUGPlLcmQWnHoJEbVVB3QTqu2QQTi6ywkFxOzNGECSt9Y/WKwcJbEPC9sNCt/MI0quv
 8MtPKMICO+Ui5Qx6vtq8TOnjBz68Gnv8RzIi2pZ2PUoAoXtNt/gZphYvJ8Jti5wnMUjzd
 aJgED4DKARYoFZlR0RhauAAA2XxXAZQo5YmvyGbwIvtwLDlGRlJxeE8ygUydJhVvW7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141783;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=Sd8UmzEdOztef5FY3Hr1AQz1hE9+rn9FLppfYMb+1/0=;
 b=osPPOnf0P0J64ChlWHlrT34kr/0HC7tibJPvRtwj53Gy8cXfX+sAJ4HAJB8oDY5ANqta
 K5Fdja6m+NX+GeuuXxBEczSQF0i1ULv7PGaee4EW2DicAr36b0H98qw1XTDzyZI6u+WfS
 NLC5t96U/8vBCFTTggAep2ZKny3o4gNDJBFSQrzZrsekaElkYGV7fCydy2AYFfpiR4Glf
 gS+FYEYtd+VxRDDeTueLutk5tjFi5Omcbsp1WOyfJm7Urbas5dRwgkwCgFAwAFnWrcOzh
 jx2SVvSeeWGRrTz/vI/Qb4YztuEDZrZX5yv7uNNBQrGMtgZY8BY5hcmRicJt+K3gcWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RpCHlrAZ; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RpCHlrAZ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36D58403FF
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E83E440887;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB09FC2BCB9;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141781;
 bh=PZPtEbRvlRqs18hXbbpx4eRshX2dFv2BkECdsBwGBVk=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=RpCHlrAZC7YGuw5lMHbSHeNxWEAyaZnRnxDvatLgqZhkO0P4Z/o1g3jW31lIafFn9
 x2o/fgJgHznpWMbOFheopwGTp22H9RDKRDQBzzA+UknqN1djVg7TSHgTZt14nB0OaF
 eqh4Vyh7Apiy8LMcbpDxoej0hXo0uRNJej39mDyus5yAQZCPs8nIwffcZOjnh+NK1f
 L2XTTvt1Z4vRa7TUn5qXHZYnFTaemDPSAwhYDU8hON7APfzaif2vBcadJ22AChJi85
 HD0ecEwbK/LhIGSZl4OjytnJWyOjG+rIE1ED2/BMqyBcWJNVywIM2l5baYwpLCOQEu
 nWzaif43PPJBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 91616CA5FCE;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH u-boot 0/8] ufs: Sony Yoshino/Tama (MSM8998 / SDM845) UFS
 bring-up
Date: Sun, 04 Oct 2026 21:22:32 +0200
Message-Id: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBAAv0L27Ca0lhr9ivFAcRfWQ2u61EgIf
 6fKcSaZWUEpCyncmhUyfUQlxQrm1MAw9XEklGdlsK31rTcGg8PCiprigperO9uOPbueoRbvTCz
 f/+0OBUNKMzwOryW8aJh/K9i2HTD3Si53AAAA
X-Change-ID: 20260611-b4-ufs-sony-794325f6f4af
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 David Heidelberg <david@ixit.cz>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141779; l=3712;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=PZPtEbRvlRqs18hXbbpx4eRshX2dFv2BkECdsBwGBVk=;
 b=LyQFKS/S38L27SLZ/ZhevTqJQCn74peIL5+5fGabM1YTVtgk/dq1swnAJ0zvzmgmM8Svfp5NR
 A39VfrHccReD/fPqba/gqfgUwS0zBg48NshmQRKvrPgywbmjhJlC7Ii
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series brings up UFS on the Sony Xperia "Yoshino" (MSM8998) and
"Tama" (SDM845) families.

The work falls into four layers:

1. A small refactor that extends ufs_dev_desc with the product revision
   string and the UFS spec version (patch 1). No behaviour change.

2. A device-quirk infrastructure (patches 2-4) that lets us match
   per-device link / power-mode workarounds against manufacturer id,
   model and fw revision:

     - patch 2: generic ufs_fixups[] table and ufshcd_fixup_dev_quirks(),
       called from ufs_start() before power-mode negotiation
     - patch 3: UFS_DEVICE_QUIRK_EXTEND_SYNC_LENGTH for SK Hynix devices
       that need PA_TxHsG{1,2,3}SyncLength programmed to 0x48
     - patch 4: CONFIG_UFS_RESTRICT_TX_LANES build-time knob for boards
       with only a single reliable TX lane. Defaults to N so nothing
       else is affected.

3. The NO_PURGE quirk for devices that brick if issued PURGE / UNMAP
   (patches 5-7):

     - patch 5: refuse erase/UNMAP in the SCSI uclass when NO_PURGE
       is set on the underlying UFS device
     - patch 6: print device identification (vendor / model / rev /
       spec version) at probe so quirk matching is observable on the
       console
     - patch 7: a platform gate that auto-enables NO_PURGE on Sony
       Yoshino/Tama compatibles because per-UFS-chip rows can't see
       blank string descriptors on some affected boards.

4. Akatsuki DTS enablement (patch 8): re-enable the UFS controller node.

Background on NO_PURGE: on the affected Sony platforms the SCSI ERASE /
UNMAP / WRITE_BUFFER PURGE operation overwrites the bootloader region
and permanently bricks the device.

Based on the linux patches by Angelo:
https://github.com/kholk/kernel/commit/2e7a9ee1c91a016baa0b826a7752ec45663a0561

Tested on Sony XZ3 (akatsuki, SDM845) where U-Boot enumerates UFS LUN0
and exposes the GPT.

```
UFS Device Information (ufshc@1d84000)
  Manufacturer:    Samsung (0x01ce)
  Model:           (unset)
  Revision:        (unset)
  Spec Version:    0x0210
  Gear  - RX: 3, TX: 3
  Lane  - RX: 2, TX: 2
  Power - RX: 1, TX: 1, HS rate: 2
  Device Quirks:   0x00000001
  NO_PURGE Quirk:  Yes

...

=> scsi erase 0 1

scsi erase: device 0 block # 0, count 1 ... scsi_erase: erase not supported on this device
0 blocks erased: ERROR
=> 
```

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (8):
      ufs: read product revision and spec version into ufs_dev_desc
      ufs: add device-quirk infrastructure
      ufs: program extended HS sync length for SK Hynix devices
      ufs: add CONFIG_UFS_RESTRICT_TX_LANES
      scsi: ufs: refuse erase/UNMAP on NO_PURGE devices
      ufs: print device information at probe
      ufs: gate NO_PURGE on Sony Yoshino/Tama platform compatible
      arm: dts: qcom: akatsuki: re-enable the UFS controller node

 MAINTAINERS                                        |   1 +
 .../sdm845-sony-xperia-tama-akatsuki-u-boot.dtsi   |   9 +
 drivers/scsi/scsi.c                                |   5 +
 drivers/ufs/Kconfig                                |  14 ++
 drivers/ufs/ufs-uclass.c                           | 197 +++++++++++++++++++++
 drivers/ufs/ufs.h                                  |   7 +
 drivers/ufs/ufs_quirks.h                           |  94 ++++++++++
 drivers/ufs/unipro.h                               |   3 +
 include/scsi.h                                     |   5 +
 9 files changed, 335 insertions(+)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260611-b4-ufs-sony-794325f6f4af

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


