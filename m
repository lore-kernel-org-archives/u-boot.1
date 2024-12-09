Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0608BE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 22:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459DD896E5;
	Mon,  9 Dec 2024 23:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733783830;
	bh=E7co/7hjn1Sav3EdeadvlSPOLeJJj0VSD+5GGs1YYks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hz9RGoVVSvRhOEKodIwne2vE875vbe3BXl0R+aADTnKCxvd8Abaa245H5BcxxR4+g
	 Yr4Qv/PFgpNukkc2nJdIEhYam9I4h8MLKc4dN5HBNDyndGNqQ/fGL3OSg0oTiYk8fJ
	 T7yRan1bQKt7Dz0VZ2IRQJ6t1xZsW0N/BM1iN7VbOkW45s4xIf5r78LONQL+LeZWqH
	 Ci6CKxYaqXuYotJWSoTujl6eO3+2JusT2yRq3x37KsqyiBccH6wawbVv/5ESkc5iyV
	 cyG5AYT95xB9z84Efajn1htCcuh/JFl/mThecm+OIzD9dhnrLNSaoyLSWwf2uyq4gV
	 UBYUvGheyqqpg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 87FBE89457;
 Mon,  9 Dec 2024 23:37:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733783829;
 bh=E7co/7hjn1Sav3EdeadvlSPOLeJJj0VSD+5GGs1YYks=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uisArRmc6ouXCvCY9RcwBPgxkc+QiFpuggP33g3ww3lD23xh2vCVnLudcFYN9XaJP
 u74FNUCvdwjp9TdFYrJZFgcYURZ1e0q3FYkuqm+ZikGIwf88bgMgYzna+IFQ2m6LKX
 3j7J10VsbqQOkV3WVL7vmLx6k92TX5mJe4CPNYYzmjYzhNPbm2i5SObyHGIWlPDcs0
 Y6IiTj37BKeWdQI3EWWh+PLiYZjRGMffNaShZY+7Hz8BS5ow80pSS9U3zCai/cvkrL
 nqmcPl48T0W9Ba/Ym53FiGwelgoW4xKdOPnW8dyXsbHHmTipJEo1fVh2+TcxvRBj2R
 lVEBpBYLAWNXg==
Message-ID: <49ce4dae-a953-43be-aeef-1202ec199fe0@denx.de>
Date: Mon, 9 Dec 2024 23:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: onboard-hub: Update the bind function based on
 peer-hub property
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, patrice.chotard@foss.st.com,
 Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
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

On 12/4/24 8:25 AM, Venkatesh Yadav Abbarapu wrote:
> As the "peer-hub" property is optional, don't error out just
> skip the bind function.
> 
> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Patrice, can you please test and provide RB/TB on ST HW ?
