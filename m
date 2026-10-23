Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D2606A31F
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gjB/r3/7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFIrAlwJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1B454089E;
	Fri, 23 Oct 2026 10:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ba4f0eWMGe-y; Fri, 23 Oct 2026 10:29:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E1AE408D3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792751364;
	b=ZWrELnLMylx8VMOUZ5oCe3j7OHXDhOhZzVlK5vv9HQ/R+Unyy0+hJ1f+rnuVtFKpyqa7
	 1bua3Ey21+J+0l/dktLQI5VRTKHleZbdekLZ2n9XG2L58wTyStE4+JrHXa3i3ZU5dqKEX
	 0WV978zOgrX2re/7iofmfYJE7D4wVUj+eheWvcnsGJyCHyMPEXNQt3f/4UF1FdyAwCzjn
	 lGjkDEuHOX4OJb5paz7139fOmw8Zp/sP/B3C7+vF3VpG1IvPJSfxa5JB1B/s9gpCvs/Fy
	 M4EZ5cxQN22S63Q2v2CFElVXXyPnQuf45sP1ATNWvaBTTD/PubWdPZ68wIpeBmKps3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792751364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pa/+9b21cliYEtUkc9AoFEV3eilIivr4nozswRtPwtg=;
	b=inrNHpAyVELZq7VnDL4ECbMlTXXr7vBJqPRFTkbw0E3Ubbn+9V3AfnRMvGrF0pVyRzm1
	 RTfFZGxKysNLjulDYQUjWzTXXWReAmDDd4HWivNSEh5ngShoeGtdb0Yc/pXODlWLGPXEl
	 jkkXy7bZl8NiYO7zIFW9rAthEsC4WCtEptfveeOWBKQnfK9AC3Cyti/5HFpQEKXGa5SCA
	 VdzlOzyk/KApw+SlsMQU9YEueP3QJkYritvGsZoh8eD1ArO+WwkEf3Jgd5BoIqvTEzGHn
	 KomwdJl2QiCynGlF3WlYRxPFzWf79xYWaYR58LttNeZQqClhJybm60TRD5JRaZKZ9+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792751364;
	bh=pa/+9b21cliYEtUkc9AoFEV3eilIivr4nozswRtPwtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gjB/r3/7/GciOlLgrw9UPUL9vKdECohW8EZlu9cevLGW1aqNRyNbrXX4mu1VQH45m
	 0C4EMrEZx44iBJF6BTXFI8JVCENoklnNoILOhejh4CmT0YKtYluJnCezZwhHomtGzv
	 ZAqvlwZ9hRi+7OvQuk1RWLqYVP6LNRhFr4PDRJZ2mcC2QFJhPOx/j0I0zLV4c1SW1g
	 RrHy6LlDCd59KlNtRG/RQGCjdLDq3QuK7l4623X8tfKZtAk6h7ugTk9tUs33RltZ4d
	 th6MK5rC1mhhiISn1EQ9Hdm/QArE9x+Zc0GzbwsV0FmKpd5HGxQZic6FAHgZD+C5iw
	 5WuqsxP+CGdVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E1AE408D3;
	Fri, 23 Oct 2026 10:29:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0990149D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3F508117D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DBO3ZUlXFX4 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AE8D81175
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792751362;
 b=BLdgi8JA7Y+l4Epf6Er2uFUWhOwLg65EbubPkecl1jewKJbTuY2A151MDnTY7EkXjEWx
 vdFoJljdjUZtxWhn06p3+nbLYdevjfljv+X8rYuEZsP8Ze+K/bhQhHMkSybm/6VmzuR7b
 N7Yv6FMKhLO7DiPux2fi+5Ifg7BCCL5yxqvNwBsfbdbv7xv58EfEAnyupvoIBkIMwCZFR
 NvnedjBvWIsKI+usYk6Hkl/sC6DOw4aH5OXjytfPWbBqX3U/HjkBsLHQ4MDteYnXL93oF
 w7hWQ3riRvFjwTDaUbO3FKzTTJJASVOjxECoaMu/Q5k/0+kwPK3lKXmZt+ugwaDkkww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792751362;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=pa/+9b21cliYEtUkc9AoFEV3eilIivr4nozswRtPwtg=;
 b=poIDqgUyGUhKRG52FW5SZiCcbh1e2xACo6LlHaLn9Opcl+NTaumnqMXJo7urZXZeRecE
 +yMAvX0zsSaBT+oIshYNYjp6X+VhNamTO4Ob/QSlxm1MGUGf2hKCQGzLgahoc8qAOJ98v
 ZO2wD4/knEC2etTOBBl9YWpH234j2MeGAFz+Eyq1O0jXig+i9+m1UxOw4XdvL1FMtmSmi
 0JEN6Iki3dt0QDsp0uzB5yNtI354RzUtI8nze+6fBbVKCMJ7957+7E0yyjLKi+Nub8w9O
 UzXDSNMyMsmvB6WC1tQDnpPdXszk3NPAAnums+T1ehOeLUB+WXVpr1Ygsu96FnnuH8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iFIrAlwJ; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iFIrAlwJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AE8D81175
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:29:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BB0560A60;
 Fri, 23 Oct 2026 10:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423C71F01825;
 Fri, 23 Oct 2026 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792751359;
 bh=pa/+9b21cliYEtUkc9AoFEV3eilIivr4nozswRtPwtg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=iFIrAlwJU+mZb50sUP6cvRh08sZipXqtkBAhzcNvdkSv7zkaTaKFvdWrS+uvqbJkQ
 +QzYDHjCE6MqDVXolxXSunET40Myx1IBzyARq4AIVwpzB99am0KKiOhkpIeYvrQDw2
 WozTi6HQ8qCoJznWr8gzqGc7AdtZUq8/Fjicr1K1TspVKLR/OXqtKSBCznLtoAyvz4
 sPEPh5LE9QIs566SJts9vLACZltf9RNu6qKuLk5YvwU33fo7bwa5XIAR4KmmvGEaJV
 vJPHIruG/hboXFz1kCFbXwmwv0ZT3t4V+lCB7t7nE1kYNhNcVEUcx4Bb6ef9eRl3Gu
 2yxtlS6+DqhlQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Guillaume La Roque <glaroque@baylibre.com>, Jan
 Kehren <jan.kehren@emteria.com>, Igor Opaniuk
 <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/5] fastboot: add flashing
 lock/unlock/get_unlock_ability
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-4-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
 <20261022-upstream-avb_lock_unlock_b4-v4-4-f4926ca925e7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:29:17 +0200
Message-ID: <xhkdb4iecpv5u.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

On Thu, Oct 22, 2026 at 21:04, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> Android's fastboot client changes the device lock state with
> "fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
> first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
> the "avb lock/unlock" shell commands) but no fastboot front end for it, so
> a device could only be unlocked from the serial console. The state also
> had no effect on fastboot: a locked device still accepted "flash",
> "erase", "boot" and the oem commands.
>
> Add the three commands and the "unlocked" variable behind
> CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
> userdata (and metadata, which holds the file based encryption keys) before
> the state changes and are refused when a partition cannot be erased; the
> TA resets the rollback indexes on a state change. A device that is
> already in the requested state is refused without a wipe. The erase goes
> through the configured flash back end, like the "erase" command, and the
> lock state itself lives in the TA, so nothing here depends on the storage
> type.
>
> While the device is locked, the commands that change the storage or run
> code are refused with "device is locked": "flash", "erase", "boot", "oem
> format", "oem partconf", "oem bootbus", "oem run", "UCmd" and "ACmd";
> "flashing unlock" is the only way out of that state.
>
> Unlocking follows the "OEM unlocking" developer setting the way Android's
> PersistentDataBlockService stores it in the frp (persistent data block)
> partition, looked up on the fastboot flash device of the mmc or block
> back end: the SHA-256 digest in the first 32 bytes of the partition must
> match the rest of it (Android formats the partition otherwise, which
> clears the setting) and its last byte must be non-zero. get_unlock_ability
> reports that and "flashing unlock" is refused otherwise, so a device
> without an frp partition, or with a back end that has no partition table,
> can only be unlocked from the U-Boot shell.
>
> Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
> erase the partitions and flip the state reported by getvar unlocked and
> "avb is_unlocked"; flash, erase and boot are refused while locked; unlock
> is refused while the OEM unlocking byte in frp is clear, after the frp
> digest was corrupted, and on an unlocked device; lock on a locked device
> is refused without a wipe.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

