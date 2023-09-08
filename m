Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE3EE57E3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 08:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996ED8653C;
	Fri,  8 Sep 2023 10:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB208865D0; Fri,  8 Sep 2023 10:34:28 +0200 (CEST)
Received: from zulu616.server4you.de (mail.csgraf.de [85.25.223.15])
 by phobos.denx.de (Postfix) with ESMTP id 3C2D58643B
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 10:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agraf@csgraf.de
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 2228D60801EE;
 Fri,  8 Sep 2023 10:34:25 +0200 (CEST)
Message-ID: <543d112a-7e23-43d0-a723-ec9ff9ea0065@csgraf.de>
Date: Fri, 8 Sep 2023 10:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] global: Use proper project name U-Boot (next2)
Content-Language: en-GB
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>
References: <044d9cffc3d8ed891b40d24c63ff74445cb3014b.1694091612.git.michal.simek@amd.com>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <044d9cffc3d8ed891b40d24c63ff74445cb3014b.1694091612.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 07.09.23 15:00, Michal Simek wrote:
> Use proper project name in README, rst and comment.
> Done in connection to commit bb922ca3eb4b ("global: Use proper project name
> U-Boot (next)").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>


For ppce500:

Reviewed-by: Alexander Graf <graf@csgraf.de>


Alex


