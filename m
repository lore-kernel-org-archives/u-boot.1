Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054BBD25B76
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 13:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EAA83EAC;
	Wed, 28 Jan 2026 14:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Eis46xgo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tjgF2k1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C901483E63; Wed, 28 Jan 2026 14:28:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAFD83E4C
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1NQN500Rz9tTR;
 Wed, 28 Jan 2026 14:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769606924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhz/6CzBH4zgSHBnkReLQLh38vrvo3s/hm4leu85Pug=;
 b=Eis46xgoFXputwnloGoYeWIWU6ZXpNIIwwzRq6UpsHBaplcWIP8+ZfdavHgnWSibacBq5y
 mM1fGg6Tupm6iCCewFM/5qIfqwFz0h98JS6FDrrBNp9GjGgIBbiuPb+nJgmU9F8NksSxSk
 JtKVyrtmnIiRpUj9j5G+KcW5V8ptA4UFVNHKmMFEceex6EPikNOn2iaDIxuIV3CEniud78
 GcW9l4Tt0ELjNWpTYKmsurjQtl8ZocayL3AYnLhCIBgCsOk7uxm7qntuh3UXQs3pXsULrS
 4xaQooHb2RmtOu37HUqHK/Xe4tghDwqqgFw77jkVzMI2Iyzf+JsX/cjFpEdOIg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tjgF2k1n;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1463fb4b-a9e9-4232-ae95-9ef425edb3e2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769606922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhz/6CzBH4zgSHBnkReLQLh38vrvo3s/hm4leu85Pug=;
 b=tjgF2k1nPVUzSoFPU5tWs5n94wVDAKG/CBc4PIsxRRTbOS4eP/A/9fmp7wV3c6ruipCb0Y
 Hz2vpGsyYtAyEUN/OhlYP5ZLhlLvL2z+1n6LZYOeZIxi3TEPwLPCkItC/12kctrVgZZqGM
 YZ2q1onqCpFdoB29RskznHbmhXKFMylE47WOb79TpQcguNBz2vBlGKDQDPw2cgY9Av+4wK
 YakND64G5imEpNJ5tAVVuzhiD8bNkKoREm62hCeMdR3I+W9UMbbrek06Q4f9QhK6mretFm
 bQC4VBjtqwxW8S2bEuQhP19891idocvSfQydABfug83pzIiaucJ2FeWqHyYSYQ==
Date: Wed, 28 Jan 2026 13:16:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: unzip: Use map_sysmem() with buffers in the gzwrite
 command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260127235310.1503239-1-marek.vasut+renesas@mailbox.org>
 <15C875DB-52B1-4BFF-98EE-FB45F570898A@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <15C875DB-52B1-4BFF-98EE-FB45F570898A@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: wwxhfm7xj7fs8gzik44e8qzbukqkhghc
X-MBO-RS-ID: 9a515dffbd8a8cfd468
X-Rspamd-Queue-Id: 4f1NQN500Rz9tTR
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

On 1/28/26 5:55 AM, Heinrich Schuchardt wrote:

Hello Heinrich,

>> @@ -75,7 +75,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
>> 		}
>> 	}
>>
>> -	ret = gzwrite(addr, length, bdev, writebuf, startoffs, szexpected);
>> +	ret = gzwrite(map_sysmem(addr, length), length, bdev, writebuf, startoffs, szexpected);
> 
> unmap_sysmem() seems to be missing here.
Will do, thanks.
