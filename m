Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7C606A321
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uueWZgXX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hebxAD2T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98C3540609;
	Mon, 26 Oct 2026 09:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z063ea-b-DIX; Mon, 26 Oct 2026 09:34:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F6C8405B6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007264;
	b=TCGAJ9k5jbCVTQTAAiR/5i5x10oesxNyG6nI7tiUnCzpU5Q19nL19a3uzOmjRTXQg9WC
	 ZOzM08kQc75f56KpJ0xkphEvssINGg+svAHDoV6Xi4LLYfVhxPoktWZM8OC2PcrOvT39O
	 iFa+mFBm7nISRpt1GvYQ2QB+ov0CHBuM9bqj9Vg77pTGpR3AnVaW7uDr6Sc3ohaAtWT4W
	 bYxLYcRB0/9O2sdqRWps4IQzZtP0ojr+sbbgvweUepBKP9HSXFYiT34XGZ1xv1fnb2T4d
	 cjEklCU4j6zi5UkZU9wPEyx9eJ38tnKRgiFehrkNwddH/b41kufs9NX3vYxDPhIRGGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=P5gv2SYgf/gru27DjaeNpky3WpgqffxNRS5PVp3NpOY=;
	b=YQKF9SvHkb/J3aGhR297oHjyXxo/WAesKwL+sT/lWzbreZ7UQaFZ0kNXbz1/27ZLJbU8
	 lwpMiDgIz3eBUh/SXI+aa2YqJMULEB7ZBoU3tkonhmagwmWHTTYoZALmN0vVmQiCC67n0
	 2CeffvDMn3Zf/RLIldTfo0PKN7JgnUL9K/XK1HqHr9QRABUTjJ62Xjuyu/khALN+fg8Vk
	 xmenlk7O1N4ibILAHRpTULeIXeeyk/BMzb3stkh5a3u0lkH0qMzaia5EZGRabNWMqKGto
	 FtEygwy2lBItrLGNpHzohmWo+YU7tBLryOpDGBi+uGeRUb4Gpug693+Z09D+lxkCDoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007264;
	bh=P5gv2SYgf/gru27DjaeNpky3WpgqffxNRS5PVp3NpOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uueWZgXXCVj2DFXzyEJS9rQKiwXO2PTmfsXh1u8GVviTwSAJ9NAuUCe0C4h7vu5IU
	 z9A9FXJGXC6aAojCZCs2Mwr42UPLFOPOnvTXmz5FGBguWFySBPT5XxgTmPmhRqwML/
	 2tQ9XCoM7ZSrR3DZPwl6WJJkbAvonVjqFDLWUk9OdeZO/86vnMXEgZUsvAyzhOXWim
	 pln8RERtFBV9SC3opv/TxXxYd904vFmQIq/b3mNiwUakKgL3DpByDK7+RSZXHsmE7a
	 WQqgKgnmOKsBmc6/yd+XobfBxDFkZXXK/zmxkvI9Z1BP3+sD9SWeUJ1pR7Sbno5xqc
	 3UiZnVKjEHyyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F6C8405B6;
	Mon, 26 Oct 2026 09:34:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E205B279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D40B580DBC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hSKa-AccmcVp for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:34:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DFAFD80A83
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007263;
 b=tNE1UlOEHLhqIJZKzSMVud4TB8x2OVumYueiVLr54QnqLx6mw1IHa99Lmr/L8PUaqidp
 64Ij2H4MG0W9LnEUwoRfreCZpn7uqvoTsGXv5qMKoHYHBMHtJROo6vra47UtKTZqsVSxJ
 zsOgEHUskVvuc7DCsXBpoaAVYjpvCLJt29Iv8d0c9LWP7YJYp18uVScMpdFGs+pJ6ovu3
 4S/Xz9GduOoU7lu3sz2PumQntYfuQt+Mh/D70io0LDaipFNa7nr9souKmSJOE1LROtzO6
 iijKj6rXvwzhwwn++vc+PVt1kDb/vH6EGJKFtVm0re4234hCPe7tIPRkHnAQy3T68rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007263;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=P5gv2SYgf/gru27DjaeNpky3WpgqffxNRS5PVp3NpOY=;
 b=MRG5AxYWLwouAm+xjoVOPjkRAsTj0bo3odh6E5GwmBgkHWwEjHktvUsobtuV8UmoRIcd
 95fFWdhb2q4jZBQ59cVHEm7swN6La+ft9e7JZ5Sm+Z/em4ASyBybd7oJJibdKH427GPNF
 noro/TNQxCe0JBujX1vn3d7o1gZfukMi4W+9DLUuNX+YTUM3Yl4mmVTjOWbhE70PyMesp
 JyTZDES2euIWM4Rvvgtu1OupxmAzRDUNsPKZAPZy1sAu03d7kgt/OGB48i52CNyufddnp
 6GIGBEY7sAFhSPVUEcnWvRL/yOi/X068SHdS+0DRAibgU0iWW+Wr3Y12bPlEqni19Sg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hebxAD2T; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hebxAD2T
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFAFD80A83
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5B1743DD3;
 Mon, 26 Oct 2026 09:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4411F1F031E2;
 Mon, 26 Oct 2026 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793007261;
 bh=P5gv2SYgf/gru27DjaeNpky3WpgqffxNRS5PVp3NpOY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=hebxAD2T56HFreyTO6vxu1yAe9D7i5l0wIQixlABWaSR+BGWkeWFjoZ4vDwglGU18
 +YzuhRJJTCT8MqEWB8DvF4qhyu6XCoICLKiqRpoXuIlz5pI6g02riWcTnhRI586tN3
 Kl+zU3CGRUTCI52PUGVtJR7w2qPvRWjM0pcj+I+gU+HmvsA13u0Xa0NvCE1xlNC78o
 YM8M7W0EdfyPkf5FG0BfsTZNP8icBiu60eUhzXBxC6P6VsBEFP+hFE/npVS/Mo8e1Q
 fS+/Aq4cnZUWEJUtF+hRCCcaKCkDxMRKGuRHgfWb+YSr2PkiwdVNRkk7qOxdp9Fnn0
 R5ra3F4jrpZgQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
Subject: Re: [PATCH v3 00/10] Fix AVB pytest suite for sandbox
Message-Id: <179300725946.12003.13769564015020562173.b4-ty@b4>
Date: Mon, 26 Oct 2026 10:34:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 22 Oct 2026 15:30:29 +0200, Mattijs Korpershoek wrote:
> The AVB tests have the following limitations on sandbox:
> 
> * The mmc1.img required by sandbox is not created when the avb test runs
> * mmc1.img contains a Fedora image, so avb verification cannot be done
> * The tests silently pass due to bad usage of string.find()
> 
> This series improve the test suite to have more useful results on
> sandbox.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[01/10] avb: Use map_to_sysmem() for flush_cache() address
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b83adb74d99c585742e684c20d27742d5dd8c357
[02/10] test/py: android: Move android image creation to a dedicated file
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/be4c8df84ec97e876c9f8a0b3b3499e03fa2893c
[03/10] test/py: android: Drop verbose printing and unused return
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6a62c505686a2c37d3b8b920ebba006d93574058
[04/10] test/py: android: Use for loop to create the images / update disks
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/9d5adaff1cb0383a68b897593a4aeebc9ab69e3a
[05/10] test/py: android: Add create_gpt_image() for image creation
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/f46f0d0ad9dedf4c9f738bcc05dec364b62ff414
[06/10] test/py: android: Add setup_android_v{4,2}_image subfunctions
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/15d92cf855f6b7cf5ec238d7fb63a07030c97564
[07/10] test/py: avb: Use format specifiers instead of str() for mmc_dev
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/8647765c5c6e2f6c623c2a44219b0dd205b9e13e
[08/10] test/py: avb: Move mmc device number to a pytest fixture
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6463b691087674824c938c331fe57368a07cd2bd
[09/10] test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/d3d0fff23a1f24e34b76d8b077556708499f2579
[10/10] test/py: avb: Fix find() logic when matching response strings
        https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/974861925ede465ecd780e000a98d64c32181abf

--
Mattijs
