Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B511D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0946880077;
	Fri, 19 Dec 2025 00:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lMlAbLKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22369800AB; Fri, 19 Dec 2025 00:09:34 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7538003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dXRFP6vsxz9tdm;
 Fri, 19 Dec 2025 00:09:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766099370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GbCqWHgfHrMkj2j0kLVu0iMODo5P5OOtdnpB1nfkBI=;
 b=lMlAbLKhWCHQqnshlakqc7of3kG0xYXd99FA986/7MfpMgRZbpnnoEdiwVa7br19+JY88d
 FPljdPwbFHUpVuT2aYlSekQazoKBHdF+GXDUbRc07zZuzLOszbp4c2LSWZgMjdbsf0nWwk
 LFYLRH98lz/4NOG9/hwYgXiCxCM9jfo70dcMwNQtSQtaoz/A+Hq9V5l01ZCtDAJBhf/yt5
 TdI/gjiV+9bQaPdNTr8APLGNU753c0y/I+asEHDW2RkHUS8HvgtcrF2X6t5No7Ns+GRjom
 h/hCDKj7ro8pCzH104lW0N3JW15BigYKiAtl/it+Q9Ek2WoyO5v1Ba3jXSjiyw==
Message-ID: <0af71280-1b23-4439-9f85-89f4341b084e@mailbox.org>
Date: Fri, 19 Dec 2025 00:09:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] env: Add single to redundant environment upgrade path
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
 <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
 <20251217205610.GF303283@bill-the-cat>
 <bdfbfcbc-74f3-4191-b4e9-b4de0e8cbd16@mailbox.org>
 <20251218135853.GG303283@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251218135853.GG303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: a4xn8iz1jh7ttd5sm6hdofkqj4hreert
X-MBO-RS-ID: 7a528717c620f417f83
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

On 12/18/25 2:58 PM, Tom Rini wrote:
> On Wed, Dec 17, 2025 at 11:58:15PM +0100, Marek Vasut wrote:
>> On 12/17/25 9:56 PM, Tom Rini wrote:
>>> On Wed, Dec 17, 2025 at 09:12:33PM +0100, Marek Vasut wrote:
>>>
>>>> Add support for converting single-copy environment to redundant environment.
>>>> In case CRC checks on both redundant environment copies fail, try one more
>>>> CRC check on the primary environment copy and treat it as single environment.
>>>> If that check does pass, rewrite the single-copy environment into redundant
>>>> environment format, indicate the environment is valid, and import that as
>>>> usual primary copy of redundant environment. Follow up 'env save' will then
>>>> store two environment copies and the system will continue to operate as
>>>> regular redundant environment system.
>>>>
>>>> Add test which validates this upgrade path. The test starts with spi.bin
>>>> which is pre-populated as single-copy environment and then upgrades that
>>>> environment to dual-copy environment.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: u-boot@lists.denx.de
>>>
>>> For merging, a cover letter makes things so much easier, please add one
>>> for v2. And, I think this needs a Kconfig option. I'm sure you added
>>> this because someone has a valid use case but it's going to grow too
>>> many platforms where that feature isn't likely desired. Thanks.
>> Do you actually observe growth ? Because this is calling existing functions,
>> so the growth has to be in units of bytes tops.
> 
> A good question, I was assuming so but checking xilinx_versal_virt (a
> platform with redundant env) shows yes, it does:
> 01: Merge patch series "fit: print conf node compatibles + use property string constants"
> 05: env: Add single to redundant environment upgrade path
>     aarch64: (for 1/1 boards) all +96.0 text +96.0
>              xilinx_versal_virt: all +96 text +96
>                 u-boot: add: 0/0, grow: 1/0 bytes: 84/0 (84)
>                   function                                   old     new   delta
>                   env_check_redund                           316     400     +84
Correct, and the growth is minimal and gated by ENV_REDUND already.

I think it would still be good not to confuse users with too many 
additional Kconfig symbols, but if you insist, I will add one ?
