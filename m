Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F9C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 10:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20FFD60805;
	Wed, 16 Sep 2026 10:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FE9TLXYlfrQ2; Wed, 16 Sep 2026 10:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5932F607FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789554919;
	b=FaH1v6wzSqaXy3cAjK3puwRB+/igqwnoyssx4pzpx8q+AHrIqvSbansmeSAJVbzwgsLX
	 KCEcx+qUPdxv3U0StfLwoTcFEJOfwNXahgCgek8qzj57ADZsMb0TUV47BGW2vVmL8egpc
	 dP5m2Q+PBlyUaRrpsE22UhaHnpA1UUEx3lIIJF53cfjXkCx6FZCCCz23+BjZFSj57FR0h
	 jGx1zclSXoS8Dr2V7Wq8lhXHWgywPYMGTJFzsxwqt1jW9N0hh3SPag8IdbwoHiIx7qfQN
	 VnaQWLoMwzIM+sVJxvEsBzm6n2p1st5Chfu69nr3q2BjjotL8y7SNfLfIXNSVVVWDeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789554919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fc3jNom7fcbn3fzN8t2QvDnG/6C4dK7jbttaItQj4ZE=;
	b=o2j006dNQ8xUKfUNGhz7mFoIaSqEHQltGPDRT2hUql0apyQncTIH6DCkX1kdQSTj9LtC
	 FjmvZ41lbkwqoNqvaYu7xvfH/z4ItlyI3PviIMANa7r+9dVUs1hky+jZi3Lw1ZxVgLgzV
	 riDo0TrgIwfnDwiStdu2LR57vCene14r6SYsz3AgTR+kF4Z78VOu5YVtMR3hNgIV1V18W
	 TV9uccMYGx1RQEENOfI+XRf5kuVryIFlzWe71yJp2V+LJLJCRpXSq09+XF6nAjR/AEeCu
	 hwMw2GccYA0YFsDsJH8OGLop8nz4yj6zZMdIBkAZ9+YEO5twfVAwyfVinRgLuc/7N7g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="VPgMeqd/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789554919;
	bh=Fc3jNom7fcbn3fzN8t2QvDnG/6C4dK7jbttaItQj4ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8Fk3esxWZj+pwbI8L6irzf1+YYKfUDa1j5mN46ZoYt6+6Tsks7usqNYpD+PUslCO
	 wU/DbznDUIJnkAryou/BvfLtk5zW+QAPJP57caDpRjK07ovXQvXZQor3rP6vTuPq/x
	 rB8jXpNKM0gXlOvMcEhkXjvxqHj94prIE4lox2RIQD9BWfRuVcOEDq2aAcfc6nmhfA
	 lgvyWdlqbnX8RhUx7umBU4Zm/ZrNpRRGbyZ2VqA9xps2QCSnSTPAok6PFeKZeiods7
	 UYCch2l/TS8HTNzQX3UCJbOAOD+PGLe1BqaFYG3LcAj7Ec05Ay9wPCuYUmtCT0edk/
	 q9GXmcO3dOXrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5932F607FC;
	Wed, 16 Sep 2026 10:35:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F2A62E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 10:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 506A5607FC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 10:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OhpirZzeCHcS for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 10:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 662B2607C1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789554916;
 b=s/ocIzzYxI24jHfRyO/OOC37lWOUh5WihJgHgCsHP/HTc3bdR9zJb9/TOtFPXOUBZCOF
 wo0/X6sOEb6swvcIY8xie7/kg4oj9nMGgIYjkpw6k0cJzFc255YLtHYgIgfxSS1w85ihu
 p6NGLDlm2hdu3IJPlwoYmqRL1j30lUXUyyhRGCrXuMFObzSpociU0dBiIxnXVYC/nCIZA
 COpDgG4pMZRlRU8L/btNWgG2wKFmv5yVc4nYhLIR1OTPlZuPrs1E2TJSL5JgOUSDAQgsv
 mqfvXtPRfycD1PddkyPjM0AOxsgkzB9YQJhmRmc5QnDTE1+2XQks/YxA4Yr8WJ5y3Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789554916;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Fc3jNom7fcbn3fzN8t2QvDnG/6C4dK7jbttaItQj4ZE=;
 b=Na27oz6FienTU0JAgjj7ayoqcjgB4h4b9GKBw7sVyMZWL6odOzJKBs1xr3DR02xMN7bi
 iJyn3Lti9wWTljO1mShK0EXlu24qI4mxtjrjr+RDQ9NDLJPw2oE4Kskyh4PcU48KHJFsM
 kiTxsa5Qo9PyJbcWIe4bIYIUHhQZI77dCjHCazaD9lOppsycACYn7tdvX099vL52bkhY6
 bvol6/PRJEKf1FUil0sEx0/af6RqLPzvZVvU+11IxnCEQKgtu4SLMK+AX4zdR5bz/kzFx
 TqEROLDh+WzxFHwrmTLKs8uOeGkEweMfXQMyZ6wuwJzv8m6Wf25KNxzY0vgLghHYq1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="VPgMeqd/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VPgMeqd/
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 662B2607C1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 10:35:15 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4aac9321so631577d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 03:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789554914; cv=none;
 d=google.com; s=arc-20260327;
 b=nBdKkdxNLLofjm1WYSa2KQKlc3BfYUC/ta/RO7NKy2jgnLCk8VuJPk418PLEm6Fm+C
 P4ILOtag1nCopywRSBQs18iSCpear5nQNerhEk3QaVVEuFhFpk7JVFeceqBYI/7d51ib
 BAuyn1pSFlnug1H7ZSXUXH0gQOSSs1yJeX8Tbi806LSJxcW9OqVXNDloSDSbXWW9UVB5
 U/QAKqprxjbpOXG605/ukI+yb2I3On7smPGkhsbcCSwnl/yO8HLQSqxqw8e9c6JPdI3s
 zdgLbPnpk8K+aUARQEHIZh1iflhY3ju233m7szCGfcTpc0tEtakeT7M7XuCTEUTDMv+5
 +nDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fc3jNom7fcbn3fzN8t2QvDnG/6C4dK7jbttaItQj4ZE=;
 fh=tNLf/+MrBZDRr7Ng5fSui9q2ZXbx1IfYZXPMDuKbLt4=;
 b=qiywIaZ5gRwjfV/kswMSkBldE0VAVjNlEcWMuHlyHRxY1uYLwzeY4qFTMBEQHnqEn2
 YMqTcODwTJT72qeufvxMnEw7sUHKBZzKptxQlSn55W7aDtJprWY7hYmMBQoQFnMG0fUb
 RmGqGzYhzCakvIT0cQ/Z6cHBerGPEp1bg9W4y0Kng8HZPEAsTmzwHVsJg7YQdzfrA0p+
 QHJYGSY3zu7wpyUrMtOH6EWXbh04nU1jns0nGa3OHupzTsT8NlgGXutjULSqAL6ekUm9
 HUPUCLNL3TpGgfKZCqdD8HKa3mZvWv4hsvXzjJSUBym+etdQEX2/eBk1pkf69q15lLnn
 ltWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789554914; x=1790159714;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fc3jNom7fcbn3fzN8t2QvDnG/6C4dK7jbttaItQj4ZE=;
 b=VPgMeqd/s26EKv2wRyUxwV6WBBseED54v38TJK8O7vKXMcDPtO5bZYfCXLYWf/e/HT
 N/qQpg7ru6DqGy3pNSHov+sM/tV2KmZ+IyIrXMfyIwxjmSuj8bDU45UYUZtkRnVO/aJD
 37Kb1eoINAIKVLyMQsffioiTE418/egzhudNFusC20t+3t8/1UgACKQRIT4p8Q4ly6Au
 C1MaviJR6Oe+kV4eEHAzoGCKNMbourWr+55L0/A1ZWvWxHBlDjrmAcwfeZd4/YOdlCQG
 eD6SOewffVEKVdLnjipZJPRtC9TZTSu5Zssi3wUW32uVjjsFb3Ze6gi70X3rOu5qWChv
 SEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789554914; x=1790159714;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fc3jNom7fcbn3fzN8t2QvDnG/6C4dK7jbttaItQj4ZE=;
 b=dmxKJEIWbqsd6ntECnuBhtENaaWDK9C49H49eBof0PB2FbA5WqVs3sVmTJv5TbqYKR
 U8pp0/7bEi/e0/b6naQtc+BULzNSaMVLGV+5Rcw7bqvc8UWVba4kZM+Ic8nuQuVgaKoV
 up8NYwxPljWKFq92Vhu89Upok/gCnLeo3L3wNRH8YvaMHYRzAKh6VyHzfQve9lh9ii62
 ZOTPRmURFinRQo/jHzeoyoJEy9O4Y8ngUCmkopy+4y0DxoJmJ6ABKQ+bs8pCPCnREUdd
 e4fuoIVI04RO/svL7kp6p+PtZz85AG3CtKWlz2vw6LXqxvI3of5G1h9WnAHAEpT4sd8t
 GD+g==
X-Gm-Message-State: AFuF++nj4yyA3pcb/GV3DgXpdY/4Hm1scTyowT/PcCzlbOUdxkqErAUf
 7FwVFqc5iSx44xS+xaeMg6/NaqihOtFs20GNodCC77TszzUstkLe08U9L/+h9yTXQLAHUs4lVI5
 Kg68KvWI2Ulx3iLVz1qn1HSWzIMp0qCS2Hw11wLgymw==
X-Gm-Gg: AYBFou1yIDaQ/yWBX4Tak675BfCVkEQi3j9/isQpReBQqezCY6OWMBb2Kb7t4JYd4bp
 wFXpAFqyLk8d8+xDTS+QAVkRn4wkQKAnntwlHfLcoDPShrx1WlBGru8qbz2UGbgIY4nVrWMZ5mC
 slJ+B3bbBLamIhaTCSGdDbKmI70FQVl3bQTu3FcFN+Zg0yaed0VQB3xP50bMF8Kwxtu3QqhRr65
 XOA2DYmickU0ZFEQEi7AcvClRbF38HWciFFdwFqepPqcgHnAm+3Oc3ry+XWVXObI4vB6mq8f7xD
 1lRh7D/vFr9YuFxQiq0KExCV/7n3bEnBxjpLIf+soSMlUvnevkHQ1xbMbbiz6ch4WFkFyzpLbmM
 Jxq2GEknluuRTSu8WNjDr4PW+cqSR4Hl7mAvN4bUqlA1hgqFkt7oL7KQDYHANHkutdL0xG2x0g8
 MA5XBweNwQF8iovVetUL2NI3G2wW++f/d8zGgOhKAsrjtmL1+wpomS9aL6lGUIZbHQOWAIQRujS
 cftj+RdVNFuxHg6fl5FSPFHS4Pk2fD74TVjgxdb0oe2Z6nEapMCO+V+0IInR/f4X/eUyUktTLzo
 IsjYGSUNH7jG5LpviaoYFukhtcNKDlAnIOQWj4M8crdiZF9UXDXT//SJNI+Pj6fxt8r4D96JP2o
 1Fm3Fi+cYUOkka1lr38+NthEzmsD6FKqSWNBMeagDmcILuUS6Qj38
X-Received: by 2002:a05:690e:4514:20b0:671:1b4d:cc0d with SMTP id
 956f58d0204a3-671631dea4cmr355587d50.17.1789554914361; Wed, 16 Sep 2026
 03:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <2230d6d0-df47-43bf-8f68-947869743d3c@siemens.com>
In-Reply-To: <2230d6d0-df47-43bf-8f68-947869743d3c@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Sep 2026 12:34:37 +0200
X-Gm-Features: AcwNN1VowwoyDiVUE3b6dPcVIvUGsh0xBXUT4_UKIw1lfSFQy9nWvbKxE43FUHo
Message-ID: <CAC_iWjJvGk5q2xCuUrfxYe9yQ=WbwiVkZ6mpwZWtXTaDy+1ymg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] optee: Add support for enumerating RPMB-dependent
 services
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jan

I'm on a trip this week. I'll try looking at it and sending it over by
the end of the week

Cheers
/Ilias
On Wed, 16 Sept 2026 at 11:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 10.09.26 08:56, Jan Kiszka wrote:
> > This allows to find firmware TPM again with recent OP-TEE versions,
> > possibly also other services. The StMM service was not affected because
> > it is directly invoked by efi_variable_tee when needed, and that is late
> > enough so that all dependencies are available by then.
> >
> > See patches for further details.
> >
> > Changes in v4:
> >  - avoid multiple binds on same optee service
> >
> > Changes in v3:
> >  - don't use dev_dev if there is no valid dev
> >  - add device_active check to optee_rpmb_available
> >
> > Changes in v2:
> >  - fix build breakages with disabled CONFIGs
> >  - structure code differently between optee core and rpmb
> >  - debug() -> dev_dbg()
> >
> > Jan
> >
> > Jan Kiszka (6):
> >   tee: optee: Factor out service enumeration and binding functions
> >   tee: optee: Avoid binding a service twice
> >   tee: optee: Add support for enumerating services that only need RPMB
> >   tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
> >   mmc: Call back to optee after a successful mmc_init
> >   mmc: Make "MMC Device not found" a debug output
> >
> >  drivers/mmc/mmc-uclass.c          |  2 +-
> >  drivers/mmc/mmc.c                 |  4 ++
> >  drivers/mmc/mmc_legacy.c          |  2 +-
> >  drivers/tee/optee/core.c          | 64 ++++++++++++++++---------------
> >  drivers/tee/optee/optee_private.h | 24 ++++++++++++
> >  drivers/tee/optee/rpmb.c          | 20 ++++++++++
> >  include/tee/optee.h               |  6 +++
> >  7 files changed, 90 insertions(+), 32 deletions(-)
> >
>
> Any further comments? And do we have a chance to still include it into
> the next release?
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
