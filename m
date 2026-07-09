Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E6FC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 06:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9DC84A48;
	Thu,  9 Jul 2026 08:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="O3a0VWr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5109984A51; Thu,  9 Jul 2026 08:13:09 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E2B84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 08:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2F781193CB; Thu,  9 Jul 2026 08:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783577586;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3YTK+jXpE6rMZkmtwRPtxB7VuFECbqoHGUSraIdrC0w=;
 b=O3a0VWr2U8ohog6v8QbqqeEou9jU0VmQFymaes+FU2V2t/2vyQDx6ubtdk2inFNRMwPV2W
 f3Al4wKaoAGU9rve7tqNDk+9EPfyEwyPAjh/JN454zVe+zA9ko1d7kzeYlHCp5cAJ86MYV
 tw5nMuae3e2rAwo2n8G1TRC+BPDEv7MV7cR8u0zcdvrPhEpKdBBp+974VCB6VxIKVJzuQq
 BCjBUJQ6dQEOUAcX0MSUvSTOdqPpuSOgBuqKr7l1SBJSWdRIFwVAUxEPrJAwCMUFWZeseV
 2kHX/+DjkrZtSe4Bp1TomVFMOQHK8ZGLXN69A0A6Tm4XMNbD6kSK+9AwdL6L6A==
Message-ID: <412716b7-c39c-873c-f388-ae72d132fc3a@nabladev.com>
Date: Thu, 9 Jul 2026 08:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 00/10] Add support for ubi environment to create
 volumes (v4)
Content-Language: en-US
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <cover.1778657347.git.weijie.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Weijie,

On 13.05.26 10:02, Weijie Gao wrote:
> This patch series expose more ubi helpers to allow the ubi environment to
> create ubi env volumes before loading if they're not exist.
> 
> Changes:
> v4: Adjust command message. Error messages will be printed in both command
>       and api call.
>      Add parameter check for "ubi rename" subcommand
>      Fix duplicated call to ubi_require_volume() in command.
>      Squash api function comments.
>      Change all return value to negative.
>      Add another kconfig option to control whether to create static volume.
>      Read environment volume only when it exists or has been created.
> 
> v3: Fix command messages
>      Fix some incorrect code flow and error handling
>      Correct dynamic parameter type
>      Add comments for exported functions
> 
> v2: Add const qualifier for char */void * in function parameters
>      Adjust normal command message
> 
> Weijie Gao (10):
>    ubi: remove unnecessary extern directive from function prototypes
>    cmd: ubi: mark read-only function parameters with const
>    cmd: ubi: use void * for buf parameter in ubi_volume_read
>    cmd: ubifs: mark string parameters with const
>    cmd: ubi: change the type of parameter dynamic to bool
>    cmd: ubi: change all positive error return value to negative
>    cmd: ubi: reorganize command messages
>    cmd: ubi: export more APIs to public
>    cmd: ubi: allow creating volume with all free spaces in ubi_create_vol
>    env: ubi: add support to create environment volume if it does not
>      exist
> 
>   cmd/ubi.c             | 276 +++++++++++++++++++++++++++---------------
>   cmd/ubifs.c           |   2 +-
>   env/Kconfig           |  20 +++
>   env/ubi.c             |  65 ++++++++--
>   fs/ubifs/super.c      |   2 +-
>   fs/ubifs/ubifs.c      |   2 +-
>   include/ubi_uboot.h   | 106 ++++++++++++++--
>   include/ubifs_uboot.h |   4 +-
>   8 files changed, 355 insertions(+), 122 deletions(-)
> 

Applied the whole series to u-boot-ubi.git

Thanks!

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
