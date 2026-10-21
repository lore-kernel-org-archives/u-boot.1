Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689F606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HDEezsRZ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UCvf8Awh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2B5F607D1;
	Wed, 21 Oct 2026 13:13:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6VJcuJ-xcx1p; Wed, 21 Oct 2026 13:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18E3F605DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588425;
	b=nVWYV4EkYVDh9rV/uT4rg2AL71LMJZWR6ImAfgE3DQeVBUISF9TxvhvCN7WBq2M5qDXm
	 qhubgECFBLdm4shdkFveXNpd/s52b9TmaQv6KIUf2dA6rsYQOYkAyp3aLJrZd3V3LfYKE
	 FDm/SDHNZY2bRyQhXpL66NEhMpxln0QEFf0YnghmMqRg4PH5M5iFovfZGdHwmzV4xEaHd
	 0s1PWMP942QinKeXqSvIV5qAoVy96k6VT544c9t49LdGiNMs+UHxW8BXxhyh4CVn/6iwl
	 2pOIQ0LYg9Hgq1+wxkwSxops6Yd2/MQFpj1Fx6hpuX58/0GUZViEGMMG11Lep6XQ9UQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6EEWvM/4sbPIDnU81D6o9Hgo1ggWlDKIlWtUyNkUESU=;
	b=fyXEl+W4jBKZ4t0DwA5CqLLp5srFbhs27CUBkUGHTtCtrXzTMiLmERlkid+2s4WHlkOg
	 5YCe3QM7C734GTtckZyaP96Y5U5lKGyFTUnqNEHZ4ecKGiCG+Dt7Uvhp9a+UqnFVNlZ+6
	 dpwTLtvBoZMnSLoIH9H6h5AJJdKJlZJcESSrwc2PcQ4gDofG1bpUYsxRzTF5Q6vQbWLHZ
	 WigDE2cOnL2KyK50b+EWeXtf7eHVGRay9dOqu64Y+uV7luffzq8mydLR6tAnlWNeFQL1v
	 qD0kqypsrWi7RzZ3ErurZTysj4qsaUBlR2XigphyErTgmkATiYrQKEMQn/GeeU1c2zg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588425;
	bh=6EEWvM/4sbPIDnU81D6o9Hgo1ggWlDKIlWtUyNkUESU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HDEezsRZCwDLdscgAGQsk8ISbw/ZBWSQmB6aDkeyD9yffeUG/ZlVd59LLLbDPbg1w
	 agMClYiLb0i1X/tNOsdzNGB5fwrcptf7OPn/SWz3HRzYO6oxRzH+JRDktQE3396Lhg
	 g63eEx6ao1XWW0p5r94yhl/SbsHhErQY89mGZyarTEHQqSVjEIVNG+zrsHgs+hzmHk
	 DPUKttO+ZHVOq7tKH4oGNcpBrnb+TZHQ4JhrFu0MLv8wvYy/d0caZMTjBSMFvT0RMa
	 nQ8K7Q3lGIZow6Z0bdCtjrGugAxCkYn3bh+dVlfpUWQ/MA0voFIvpmQklG0PKe041l
	 sLs8zn8KEF7RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18E3F605DB;
	Wed, 21 Oct 2026 13:13:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3A1523A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D60C08084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5bCsA9F-TVO for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F039807F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588423;
 b=nI2AUAgjVcbJEizjBEp6xMNHi4N+Te/+oey/49/K3vNyXPgDVeQtrf7ELL03szUSvSMc
 qmlYxerIC4WPx+spCPTGAF8olJMmaZq8+7EpeR30gd7KAENrBh7r+taPTappNoxcoLwSa
 HMFYZLCSDU9FRUdjPEkaGAp6HcNfEUowGRWI8mBRlW1aS7CLHC/e3Pm8yGq4FAZkMw4hO
 ix7vyBH8QjGHHq92GghBwwugCDbJsHM/CsUNH4ch2eWADrgmapwX+tFHfJGnQjkfyNJ+T
 ASnUfbJ+hJdVqEOAdRYE6BxMEtXuiC1/kmCN4lSVrKTIiZ2IGYSePom2xH7vlKyAy5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=6EEWvM/4sbPIDnU81D6o9Hgo1ggWlDKIlWtUyNkUESU=;
 b=lW35ajPKqkiKUc3SfJz0NYvqHRs6T5yHAt9Nav8Iyu4vwUwXJjOzgf/0gmcAwnGflPBj
 m2wftYY9SwR17Nw6dMgJKWhuliWVSJ61ZK615If3Iadra0TteTDDftTFzz6RYx4NqviEO
 w1CFmmm+Kkd/A1tuZGEnec9ODekk5SN0ZxDwNJAqila6f8Iu2XUDa0toE94/Npgcg/1L6
 QZvNjuChtiWyMFahcI1RiMz1rA5/TokBFoiAhRXpICSpQXlr5DsP74wuNgC19a2rhF9PA
 BxbT4OqoAbEmO2CnsxHmbrYDOzLJ3ywuGXX8H+fOUiw6HOtyIB+ZFYDuEhL4NGdFSxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UCvf8Awh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UCvf8Awh
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F039807F2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:42 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2e9f6a16aedso3974535ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588422; cv=none;
 d=google.com; s=arc-20260327;
 b=gw3LYtPKZN9eTYIp6vXkMltADJzsWVVUoLreTtW0M+Mh5WMldrvWonxluC5SAara6a
 bzzvUcB6ymIlXJ9hysrR2HLHC3z5nG9gOu9pvPECziFeMotRWEGPvCTAhNk5tDs4vqJd
 DZiCyTBTlfHintOqjTqcWCmpXcMW/tUxAU6ZUDBe/LjdfTXHYTLqQDhkXRrd9YKvPh8O
 Gkm3jkBrsPo8OKkwYNbL/Xeop8T3U77R/hueFPCzHaVSKRpdzKyl6K8jIdN30jESCuVc
 9yIhNHnOYJbVYGfezQ5oKzu46T7Zo4owKnD+S+RnwVeSZ7IZrRfkH1088MAgeeo5w5WY
 HojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6EEWvM/4sbPIDnU81D6o9Hgo1ggWlDKIlWtUyNkUESU=;
 fh=NE69m14VdS+iLI1i0Nk+Z7UEeZ7dZqybdllMvaA72+o=;
 b=UMBNIBJa2gmJaaHsjeHau9a3/N7iVGeaN9fPooUuEeqPhY1NlSzBDGSSmcpue++yp5
 Wz2/3EL/aeUn+2GHwcTfhlRJuclrHhPu6fIiUmJNRa5KIsOFDdFesixn2cE5MOgZbTyE
 8YF7fSDeADZaSUnr7ljvF/q7G6ZqkAEsAWQo8wjB/NP/6Kh61eLZf8E4bkjog6hfTjeH
 xH/4/LzficZhuVDwzwCg4M/CZSjI8fgss3GNfLEDk9rg20IH62k6QLxqXLtxOhPrWcjh
 NLGSbXh/ZCn1LO0a8zHlG9nccrjrBAHBnX10LkoEbhnKFN/Bp/S/IRfIZNKOmDoaDo0v
 4fpg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588422; x=1793193222;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6EEWvM/4sbPIDnU81D6o9Hgo1ggWlDKIlWtUyNkUESU=;
 b=UCvf8AwhcGQl+TvaiWZmFAuIWBlsETswG8v5Ghe7krVByQ1vKMMVTvF2qWNZ/ZUHks
 t0Hh7B+ICtZoJdSPcX2AlZe1OnPNLYrjTNaU9PP/1AkKSC3hgl0pPiPNl0OTgAX62d4I
 vndSbBoy53BG6Ka/9OseriksahGl6jG+poOko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588422; x=1793193222;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6EEWvM/4sbPIDnU81D6o9Hgo1ggWlDKIlWtUyNkUESU=;
 b=J/Lti4bxZ8lGQNbsAZ8PENm+UPPDdPO9QV30GQaAqtp9lW7ejXvTOuDIpez9+XpEUI
 2e/2my5yBIqyMgAbEgEBoaKDLsPnnOZPwWxD83yOgmry4/lWMiXwRCxRESt1AmW1x/m5
 C8++mPX5RRYkxNxefMt3Sl1eeV6cEnNdZJ1TwzS9Qb+lrNH3edgyZjJTHAzDJDC6dttW
 Sd6ncecavF4V97EoAqPJce/iTKHcMnj66eqc4holmRzX0NueIajcV6jItJcBr/eA5aXc
 zNjA8AH5C5jCcviBQ7x/3RM5YJmJcbRKknDYCcywYKIGhO8M9+bCd41ooupxRZpAu1RR
 VjWw==
X-Gm-Message-State: AFq9FYLeUIO2ESi339q5dk1wuSW+w5zKbOgKRmRgV8dvSIBg27HPtTPx
 6P/HhqYr442UULpSd/JZyFh0ywuXH9OwW8NuAQ2IrIcvAeK49GiEwHbjuhAAThX+bV8rIXjjR+7
 zuiUNII0+SuRx3B7GlZJP6NwSYY1Y8r74dSLyD31b
X-Gm-Gg: AYBFou342ESOLh/HipmH7w2UODgZP8Wwvgis15qDlNFyokPrlex6Q72TA5usR0XFld9
 7qpWiNWHBOMQ2JFYbl73P+A/DYCp43CQBN7InTeDuHlOKrAiiwTqXbm2Iw7yX2KxqTfSSCC1N57
 oXQKyCUavDesIOMmfgoUzw5JnNOSbcZzXNAv0RGq5k52rA8d8edrLS9mpO6bdOoyXG3t7Z99FeM
 7AjAo2NXwkqjumh5DpSZWQovGVrjlS6dBz+G9PAy8iCQnSamrDys6dAqCfG2liL9vStdXuuLhpB
 p13EKVCkxswdU4WWPLBvl50sDyvMIBYjyqbW5LkOkuZ+n+DCfZ9coHYYyhRQxR7xroAcyGXFtCR
 dUorB5fxDNvtRU0J0QNEv7a1QnVUvjZSQ+Ec=
X-Received: by 2002:a17:902:eccd:b0:2e9:99cc:154d with SMTP id
 d9443c01a7336-2ea43fd3590mr17601445ad.41.1792588422112; Wed, 21 Oct 2026
 06:13:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:13:36 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:12:44 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-2-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
 <20260824-improve-logging-on-missing-uclass-v2-2-4bee2cdff72b@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 08:13:36 -0500
X-Gm-Features: AclHuK8NnAeYcABtgdg4cW7Y3htpasuQqkJFZ_QN2COB4fYiyYGJhE2BVh2OqTk
Message-ID: <CAFLszThUyioVpQcSBxSJmf94m=ENpdfp==Nt2fmf+Z52RacZ3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dm: uclass: use dm_err() for a missing uclass
To: jstephan@baylibre.com
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Julien,

On 2026-08-24T08:44:18, Julien Stephan <jstephan@baylibre.com> wrote:
> dm: uclass: use dm_err() for a missing uclass
>
> When a uclass definition is missing for an enabled driver, the board
> cannot boot, and without any extra debug option enabled the only output
> is an obscure message with no hint about the root cause:
>
>   initcall_run_r(): initcall initr_dm() failed
>   ### ERROR ### Please RESET the board ###
>
> The existing message used dm_warn(), which is not shown by default. Since
> this is a fatal error preventing the board from booting, use the new
> dm_err() helper so it is emitted at ERROR level and visible by default.

But a missing uclass is not always fatal. Any uclass_get() can reach
uclass_add(), and some callers treat -EPFNOSUPPORT as a normal 'not
present' result. For example, nvmem_cell_get_by_index() tries
UCLASS_I2C_EEPROM, UCLASS_MISC and UCLASS_RTC in turn and skips
-EPFNOSUPPORT, and board/samsung/common/board.c does the same for
UCLASS_CROS_EC, too. With this patch, a board without one of those
uclasses would print an error on every lookup even though nothing is
wrong. Please can you check whether this causes the CI failures Tom
mentioned? It may be better to report the error only on the path that
is actually fatal (e.g. binding a driver whose uclass is missing
during dm_init_and_scan()), or to adjust these callers so that the
message stays accurate.

> Shorten the message as well to limit the code size overhead.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
>  drivers/core/uclass.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Regards,
Simon
