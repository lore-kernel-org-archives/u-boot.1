Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D24C04E69
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A354486977;
	Tue, 15 Aug 2023 00:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ty0a8qpe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="REI5r4yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64AD286986; Tue, 15 Aug 2023 00:33:12 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A281686958
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RPq124786z9sm6;
 Tue, 15 Aug 2023 00:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phZNEzVDGvtG6C1NtaCWtQFzviiYyBXQHRRqouawc6s=;
 b=Ty0a8qpe41SLe51MS8BO3uamdY+5HwqD4fuHTuEIXyvJOBrlWr9shyCDXEKxhtJ1HL+Rgm
 j9PYgcZRCdD8elF/AH9XU947KXVAfo7Bc//wIHa4P0kXbE0W/C4WrkmaO8qTQWqR5Ae/do
 f82c9yVehmPufWvuc3rU1n073dUsq4QgeOjkVRsSVuETl84W1ETD/PILmXQ7/8jn+nONFW
 Boq9hOgZigtHbqLVaBcOmHxCR6/DL15VanuAMoE0frjxkH60Oit1rLLpEOHqOp+JON/K8n
 T6L5RClq6NHFx0Qb6NN//1O2JrirmtqY86A/HnkRkldg3PsZmLL1WWXJU8YwIg==
Message-ID: <39a84296-93a8-92db-1c1e-964ed45f634a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phZNEzVDGvtG6C1NtaCWtQFzviiYyBXQHRRqouawc6s=;
 b=REI5r4ylER1H6YxyhLfxvMnt+v//HqdleBITM8yshPE/5hhOBfrk8OB5gwcFsIW/tJQzkw
 XDi4XkOw0AFYtBrR0b826OtygpMTP9whRlhWN4H22hk1CVBoPgGF1tuWc5g6EYDInu3Y5H
 mmnbq5xY4WsFgvtkHTtiVgtsGASyF8YdyPjs7APdW/Wxzb9DlQGIWGNUe0k3L5K9xm/hOO
 LZYV8qEF/+pZoevYBrVwCqkalJZ+mxfJRDSvdcE/R2Q8iE32dP5TsWHRSxPpc1VOWuz9ka
 NawsEZKWKl0JjA59WEGlecj/i0/OQO23/BziZbQoovQYAD/AvEa271i9v/z6+w==
Date: Tue, 15 Aug 2023 00:33:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/17] Enable UFS on DragonBoard845c
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org,
 rfried.dev@gmail.com, patrice.chotard@foss.st.com, jbx6244@gmail.com,
 kever.yang@rock-chips.com, eugen.hristev@collabora.com
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ee2d46dde73071af73e
X-MBO-RS-META: ja3gaxpa7yromuak66r96trb3gm6prrp
X-Rspamd-Queue-Id: 4RPq124786z9sm6
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

On 8/14/23 23:54, Bhupesh Sharma wrote:
> This patchset enables the UFS controller on DragonBoard845c
> board which houses Qualcomm SDM845 Snapdragon SoC.
> 
> In addition to enabling the UFS HC and UFS QMP PHY found
> on this SoC this patchset also contains:
>   * Patches to add 'reset' controller support for SDM845 SoC.
>   * Minor UFS core framework fixes.
>   * Patches to sync u-boot UFS driver flow with Linux UFS driver.
>   * Patches which enable RESET, UFS and SCSI config options for
>     DragonBoard845c.

I submitted a couple of UFS related patches yesterday, they add handling 
for controllers which cannot handle 64bit memory and add support for 
cache management. Please rebase on top of those, otherwise there will be 
hard to resolve conflicts.

[PATCH 1/6] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
[PATCH 1/2] blk: Add bounce buffer support to read/write operations
