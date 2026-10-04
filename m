Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E3ECA5FFF
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8764980E0F;
	Mon,  5 Oct 2026 05:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VYFUcPIX7X4X; Mon,  5 Oct 2026 05:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5360280D86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177188;
	b=gHp5hVl8CGFYjki3xVdrJ12xBjOwZVFsPDkSPBi012Sv1ciOzO0ldv0XbxBd18QST2SM
	 pckGUNnZDasu7ThhUiX/O2cZNCLdbpZZVBb5iYcFKtJrg9rGlFGuOyHPS5uAWbY2xqIPU
	 j/c0MKduC0vP32msZNxnGvugLxDfcchKoPvY5j7gct8rjQNncnj17JgH+SljD3S7WmpkX
	 eY+PBHqn7HtIPJb8RCHOEx9g5anqjDEFzeOYIycZmGtDRfqxW3SX/PkarK4hneK7DiOZw
	 qrjL9/EoOeJYn4e3xnqbnI1Q7DNoIggu6dYrOQuZ6yaha4+4bl92EBBuoLkxLyEX6hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sWpjpkQ/nnazsUtG8uH9ygUrq7Mksl7B706+byDXHMU=;
	b=Lc49sIgWRsPOjPuvMfxtrNhtBiX6djAhWDAQJBjpQUc0gZU5XBKMsPdFB/EcazkeVLrQ
	 7acPTXXESd7hSAMiIRPGNgsJEYIXrxwjlBaZpw9h0bz/gyffYHS+V86wVUNkjqGAxAoUn
	 VN/52+IY8lb9/kJk55n/iaFUCmN+fitwUmJbBvUBWrOHVYBmbC9cundORYBXTju3L5N2k
	 Wjgnvnzsd7nAPKmfD+/Hzw6DzkhbqQZKkd6N+HfLMpgJC2tvK6WPOsLtIyoYV7YlFJKQa
	 Te/kIhwWD777C/h2ZAZyyGWfmip895Kc34z5egRPzEAMXHPiL7BWz2tAL1dWNs9e+Tg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177188;
	bh=sWpjpkQ/nnazsUtG8uH9ygUrq7Mksl7B706+byDXHMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E9CyKlzOETRiOyfBtxJS3dDJ43IBX5j4rkU4QvV+qCCkhWVZ7S5zars8s+VKrx5L9
	 5joVSbDyvgyP+QhOE93EjbWiDWfa9YlWgcqW0UmML4bO8aaAs5Uiey+FNtFhixQK2j
	 OMddOCKDtFdfoKWtWOWtTsK7IQP0uMZxN2OxCRZyGQZprr1fB12OyUVazqq6V2WUYg
	 iYBltYJ2lFsswWkttDjhXBwtU3UR6/rv+RnUSrCMLtlfH6pn7Q8noRJ5EpEIf3/R6J
	 iEvX++I8INMvIczRK9wMXREuqI7Mg9XkfUXv433kTIhRvMhaCTWGbZWFKWfqYeNjpN
	 4OwZQRhRXgD3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5360280D86;
	Mon,  5 Oct 2026 05:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13EF9323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDAEC40698
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzpRNPICSYsV for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:38:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0292C40692
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:830a:f787:8f00::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791142722;
 b=GOAZVBrPZ9zlCHX4fJi3qJ7Juzh2Ql0hb7z32Yk7UbKiBn75Ay4t62D8shJaiH5CiFg9
 FsuAeybhMD2nH7Cd/fiopuNonaGBV7/YOsdRqCNBLTTCs6n+3fnLqGbOuyf+1H9AvHYrH
 f72Fl85w6ZuEKET0tmTgpBX81I91Wd5Kv0A93Ts+oMa00vmsKK7b7vVk4PW5NHTW2czDh
 M0oA/8pL3rMmwrN+q1ASV5QqE/4vOCZaPKotYMRj4LRbBgiXX0WqLcBAGKpH8boH8JOsF
 9Gy7Y2Q7ZZB3RwcGWQawGV9t1VvY+AfcCm9E3LY/4Px2H0mf9cwRoLu2mc6lPrQAYLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791142722;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=sWpjpkQ/nnazsUtG8uH9ygUrq7Mksl7B706+byDXHMU=;
 b=R5B5xf+8M66aAorDhNGt7MGpWrZbNHBV34GmHd8FcpOVQ0KZ2BKtUPHtd9EqCzQregkT
 Dk8DD0PtjJfSi9Jv3TMVJHCDW7F2u4jooMxEeGohMv5r4//PdPKW95BH9+hD/f7A4lYz7
 gGf66uJEi023xhIhR07fcCXbXa41ehGpp/RQstBBLkhJOrmiObfWLT9opXInn2pe/xnQm
 tyhinPNxLE4D8rTzAZogajCJVJ/ok5f/ZmDF1Ti0CH10ep2s754elMWEJ/PUVgS6gJH6f
 +kTlGX2CNAYk11Zr5mdHy2EDIIO5vYTTNaxOQwagtW/njvzbjJd9PUFKeD9sQp/qOrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=ixit.cz; 
 dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim
 header.b=d8KeOLjZ; 
 arc=none smtp.remote-ip="2a02:830a:f787:8f00::2"
X-Greylist: delayed 490 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 04 Oct 2026 19:38:41 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256
 header.s=dkim header.b=d8KeOLjZ
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:830a:f787:8f00::2; helo=ixit.cz; envelope-from=david@ixit.cz;
 receiver=<UNKNOWN> 
Received: from ixit.cz (ixit.cz [IPv6:2a02:830a:f787:8f00::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0292C40692
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:38:41 +0000 (UTC)
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown
 [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 99E145340E0C;
 Sun, 04 Oct 2026 21:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1791142223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sWpjpkQ/nnazsUtG8uH9ygUrq7Mksl7B706+byDXHMU=;
 b=d8KeOLjZnOPSc7d5hb0dzNynDwcnReu+vNQxPZ4Lqz2WwLcWd8C2iN+N9PDzTI26tUB6+b
 fbrld6NamU5PCrau1FfB2vwDDtH/WWdP3VIBKbyngS94KUqbS0YJkKgajMeer4QZ9mwEcp
 HfTAO+5a1RU6dOPoozrRe9v86xSkyHw=
Message-ID: <13e4f65b-8145-4566-ab13-ea26632ed3da@ixit.cz>
Date: Sun, 4 Oct 2026 21:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH u-boot 0/8] ufs: Sony Yoshino/Tama (MSM8998 / SDM845) UFS
 bring-up
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Bin Meng
 <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>,
 David Lechner <dlechner@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:02 +0000
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

On 04/10/2026 21:22, Petr Hodina via B4 Relay wrote:
> This series brings up UFS on the Sony Xperia "Yoshino" (MSM8998) and
> "Tama" (SDM845) families.
> 
> The work falls into four layers:
> 
> 1. A small refactor that extends ufs_dev_desc with the product revision
>     string and the UFS spec version (patch 1). No behaviour change.
> 
> 2. A device-quirk infrastructure (patches 2-4) that lets us match
>     per-device link / power-mode workarounds against manufacturer id,
>     model and fw revision:
> 
>       - patch 2: generic ufs_fixups[] table and ufshcd_fixup_dev_quirks(),
>         called from ufs_start() before power-mode negotiation
>       - patch 3: UFS_DEVICE_QUIRK_EXTEND_SYNC_LENGTH for SK Hynix devices
>         that need PA_TxHsG{1,2,3}SyncLength programmed to 0x48
>       - patch 4: CONFIG_UFS_RESTRICT_TX_LANES build-time knob for boards
>         with only a single reliable TX lane. Defaults to N so nothing
>         else is affected.
> 
> 3. The NO_PURGE quirk for devices that brick if issued PURGE / UNMAP
>     (patches 5-7):
> 
>       - patch 5: refuse erase/UNMAP in the SCSI uclass when NO_PURGE
>         is set on the underlying UFS device
>       - patch 6: print device identification (vendor / model / rev /
>         spec version) at probe so quirk matching is observable on the
>         console
>       - patch 7: a platform gate that auto-enables NO_PURGE on Sony
>         Yoshino/Tama compatibles because per-UFS-chip rows can't see
>         blank string descriptors on some affected boards.
> 
> 4. Akatsuki DTS enablement (patch 8): re-enable the UFS controller node.
> 
> Background on NO_PURGE: on the affected Sony platforms the SCSI ERASE /
> UNMAP / WRITE_BUFFER PURGE operation overwrites the bootloader region
> and permanently bricks the device.
> 
> Based on the linux patches by Angelo:
> https://github.com/kholk/kernel/commit/2e7a9ee1c91a016baa0b826a7752ec45663a0561
> 
> Tested on Sony XZ3 (akatsuki, SDM845) where U-Boot enumerates UFS LUN0
> and exposes the GPT.
> 
> ```
> UFS Device Information (ufshc@1d84000)
>    Manufacturer:    Samsung (0x01ce)
>    Model:           (unset)
>    Revision:        (unset)
>    Spec Version:    0x0210
>    Gear  - RX: 3, TX: 3
>    Lane  - RX: 2, TX: 2
>    Power - RX: 1, TX: 1, HS rate: 2
>    Device Quirks:   0x00000001
>    NO_PURGE Quirk:  Yes
> 
> ...
> 
> => scsi erase 0 1
> 
> scsi erase: device 0 block # 0, count 1 ... scsi_erase: erase not supported on this device
> 0 blocks erased: ERROR
> =>
> ```
> 
Hi Petr,

very happy to see this series! So many Sony devices of this generation can be 
re-purposed but this was the main blocker.

 From sample of 25 people on today's workshop, there was one Xperia with this 
issues (and since we didn't had microSD, we couldn't install anything).

Series,

Acked-by: David Heidelberg <david@ixit.cz>

David

P.S. I assume when mainline kernel gets the fixes for their driver too, you'll 
revert the manual override in
` arm: dts: qcom: akatsuki: re-enable the UFS controller node`
