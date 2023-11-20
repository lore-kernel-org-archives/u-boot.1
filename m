Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C99C5ACB3
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 02:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCADE87525;
	Mon, 20 Nov 2023 03:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700446083;
	bh=rDA+oYfOwYcOmDKQQzZptqBLrQNnnpQFbealkcw7Ij8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRdCgciQ2loP5hvhtJRZ3l3whxg7XnltAJIWhCdAeNJcCZxN3Q/XoFRlEp7DLGg9+
	 hHSPyCDUoM9YjFD4QyaecrrIQBQmE5xhUoHxu8AcPQRQd/+qw0XvrSTXpMT/SQvPMO
	 1gv1RREdMI+s5Nrw/acnSIusO7lxKmGhGySThuD9WnirlQIAT4yh0JHlyX1MeJ9qKg
	 6K1u6EHQGrO/JQnwRvStNbLoTrHgx3UUYifqGKcb1a6yTdJXPU+tkmBdtO1EryFARh
	 VY7D/Io82bkYMT7wrOrxfKBIrRjtI3Zp5FbSOs2KfsU6rU9y/9ne40BAnp3qvy55BI
	 AG6M/EQO9SGug==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 67B3187525;
 Mon, 20 Nov 2023 03:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700446082;
 bh=rDA+oYfOwYcOmDKQQzZptqBLrQNnnpQFbealkcw7Ij8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g4m3HuZ+D6WKpBg/z15t+VxQCGxx5y6/1lPqPXkRNUFJrWaDAFR90RmgkzanRn5Sc
 clZ/tVQXuGP0q+9br1O1DVjXQ4Pw85UZZ4kmVk+9fbpCf70RpLNiP89B2SXu12gaMC
 CsbPvHTvMhPjiW5g4dbZYNuBPRurcIHtnOlQbQZOL+x+Q+9jKtbYokpr7/8FBTpXdw
 YKXJFJEUgiW4LjSqYAlqtYQkUfJ36p+Oic4bLWTpsx83MKBfK1SVMYsFrQ8IioEZhS
 Kui/GAjMIHClbqXno5aNJGOckEfVvkVKNBJ+2LGrdHP4l2JZnft/fVniXYWuyRaxB3
 7cuURGEdq4IJg==
Message-ID: <85d597ef-1671-4c0a-84ec-0e4bdd678c62@denx.de>
Date: Mon, 20 Nov 2023 03:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: fastboot: Add missing newline in pr_err
To: Simon Holesch <simon@holesch.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231120002024.32865-1-simon@holesch.de>
 <20231120002024.32865-2-simon@holesch.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231120002024.32865-2-simon@holesch.de>
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

On 11/20/23 01:08, Simon Holesch wrote:
> Add missing newline in pr_err.
> 
> Signed-off-by: Simon Holesch <simon@holesch.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
> 
> Changes in v2:
> - add commit message body
> 
> Thanks for the review!

Thanks for V2, now it's up to Mattijs to sort this out.
