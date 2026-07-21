Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5971EC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 08:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08BF960604;
	Tue, 21 Jul 2026 08:28:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZ62-JkRso_g; Tue, 21 Jul 2026 08:28:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BAF660811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784622504;
	bh=5UrBT1x1Mh7w8B6EFpKpUuIaDY/zSTHuY7hHq7QeAWY=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zAi+BqroOETv1GEqunaYxm3JuHUxL43d6PGGRtg/wKszjENZNKZAGcWYfkbk/PW2d
	 9IR/abgbg79C3ejZ/dqYys/yjDg3fwQis9r0cdF0oPkcTX0CmDYRPXwKLHHY7a5xlm
	 TqKEUQaI6d4Hll8HTkUxCXg4BzFB0aasbgMbxPf9AV0eZHugzi0QOgQq3gqFl/WY8X
	 at4cuSBr5/R/Xc/thmpSHREZ6RtSLROzOGZGDEgjJCFNyKd6qUQVaxBrFuaDl8MIRb
	 1zp7yCTz3DEIZu6X3Vdk3EE28VUSn3mePrJS1yO3wiaIo1LbBeG5NLPkHFJo/S49jc
	 Xz0bVflhvawoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BAF660811;
	Tue, 21 Jul 2026 08:28:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7605596C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67B9C402EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKaoR7gODybX for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 08:28:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3ED4C40103
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3ED4C40103
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ED4C40103
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 08:28:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F046848BA; Tue, 21 Jul 2026 10:28:20 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A11D803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 10:28:18 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E254460A95;
 Tue, 21 Jul 2026 08:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6981F000E9;
 Tue, 21 Jul 2026 08:28:15 +0000 (UTC)
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Guillaume La Roque
 (TI.com)" <glaroque@baylibre.com>, "Nicolas Belin (TI.com)"
 <nbelin@baylibre.com>, Francois Berder <fberder@outlook.fr>, Sam Protsenko
 <semen.protsenko@linaro.org>
Subject: Re: [PATCH 0/2] avb: fix memory leaks in AVB 2.0 verification path
In-Reply-To: <CAByghJaRbP9Rx3VYRPFS+yfjKbx6y6c8wX3MyUE+HjnG_-L-4A@mail.gmail.com>
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
 <CAByghJaRbP9Rx3VYRPFS+yfjKbx6y6c8wX3MyUE+HjnG_-L-4A@mail.gmail.com>
Date: Tue, 21 Jul 2026 10:28:13 +0200
Message-ID: <877bmokaqq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784622496;
 bh=5UrBT1x1Mh7w8B6EFpKpUuIaDY/zSTHuY7hHq7QeAWY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FSTqr2bKofiE9nv5fLwbzuKZm7uvoRkfD3fTS5AtVdbDpEIcg6VqZBRJVIgVjN9z2
 2bY4bwhVXuhAP9Xqh/TwjoZtj9P2u49hqqK/dMBE7Yvw23MFY0AJQP1lvRoQq2Gv/T
 rAA3eGkwgfvQ2vVOlQMmDcx1sUJ1dmzYE1XPOLahogEsvJvclCaZUtrmovENvWzv9n
 2FfynCuC/BNNb8jgz7biUaWQ1xVXs0HygjxWUfSls7fa2ib684WT+6O4oMl+QcvQAo
 IlhLAor2XYtiIXdGm2/foXzzA/dzdJglpBikoz8VpCGu2/JMErMPjJLmbyO+rN39VP
 EoarZSiBbmsSQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FSTqr2bK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FSTqr2bK"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Igor,

On Wed, Jul 15, 2026 at 18:29, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> On Sun, Jul 12, 2026 at 10:50=E2=80=AFAM Igor Opaniuk <igor.opaniuk@gmail=
.com> wrote:
>>
>> While reviewing the AVB 2.0 integration I noticed several memory leaks in
>> the verification path that accumulate on every boot.
>>
>> In the Android bootmethod, run_avb_verification() allocates an AvbOps via
>> avb_ops_alloc() and receives an AvbSlotVerifyData from avb_slot_verify(),
>> but frees neither on the successful return paths. Every boot therefore
>> leaks the AvbOpsData structure, and with CONFIG_OPTEE_TA_AVB the leaked
>> AvbOps also leaves the OP-TEE session open (it is only closed inside
>> avb_ops_free()). The AvbSlotVerifyData - holding the kernel cmdline and
>> loaded-partition metadata - is leaked on both the locked GREEN/OK and the
>> unlocked ORANGE/ERROR_VERIFICATION success paths.
>>
>> Independently, the AvbOps I/O helpers leak a struct mmc_part on every
>> partition access: get_partition() returns a malloc()'d descriptor that
>> only its internal error path frees, while none of its three callers
>> (mmc_byte_io(), get_unique_guid_for_partition(), get_size_of_partition())
>> release it. A single "avb verify" performs many such accesses (footer,
>> vbmeta and the hashed image chunks), so this leak grows quickly.
>>
>> No functional change intended: the GREEN/ORANGE boot-state handling and
>> the locked/unlocked acceptance logic are preserved.
>>
>> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>> ---
>> Igor Opaniuk (2):
>>       boot: android: fix AvbOps and verify-data leaks in AVB path
>>       avb: free mmc_part allocated by get_partition()
>>
>>  boot/bootmeth_android.c | 37 +++++++++++++++++++++----------------
>>  common/avb_verify.c     | 29 +++++++++++++++++++++--------
>>  2 files changed, 42 insertions(+), 24 deletions(-)
>> ---
>> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
>> change-id: 20260712-avb-fix-memory-leaks-831cfd7e2115
>>
>> Best regards,
>> --
>> Igor Opaniuk <igor.opaniuk@gmail.com>
>>
>
> Just a gentle ping on this patch series

Sorry, I was on vacation and away from my computer. I will review this
week.

Thanks for your patience!
Mattijs

>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> https://www.linkedin.com/in/iopaniuk
