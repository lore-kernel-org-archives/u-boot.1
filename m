Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7454CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2EC686F58;
	Wed, 18 Oct 2023 12:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697626285;
	bh=aYzg4ZHa/V13UvqWtEQPkz6GzL+ncNI23hZHLVrwrxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vNzeZu33JaE5etGpggiDbf+dm70haJBsxy+rkXwez5BSJBEC2Yd7k8GhfL6un1Xww
	 tdP88RIjAlZRN5kD6+tlSelXab9efpGoZTU6c5aQ3GLoMoKblXun/XQVykOxBBnx+s
	 gvVSgiEvxjgggUZdGkPMe4pVl5+o0+gJcW5lUlJgDCBE7NPLt85mx+br5SmPoQgk9G
	 0ip5UOkHl+HhBbP6nNhoBE0hPe3cW0rH/WbHF/TFlDtO0LW9Qehuqts27IUlY3EW7h
	 nceT+7TW+n2wmYKyE4JiQIw8K/cVojoVlz8ae3yPNQBBVJxrv2H5+f5kZ6RP+XQ4Gz
	 0EEwyZZUUpvfQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5EF6A8269F;
 Wed, 18 Oct 2023 12:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697626283;
 bh=aYzg4ZHa/V13UvqWtEQPkz6GzL+ncNI23hZHLVrwrxY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=herzYO7t+E1FF/yzU6ZIX7VbOf5BPHFSrCURrSdpRFyK9nzt8xrsWUCbuHpFOoGzb
 qpNFtEFX+Is9ZCIMPju/2aoZKaN7Dz2I+HRhmmLRY/8ri2JwRDO/v80oEcLFfzAf9W
 EJi+JtvFfRjQasEQxjuwaMFIiJ8z5zAgPahNCIYZx0uGWfSAMtvS1TEgHQtemyisJv
 u8+q02QoO7JOHKFsfDKPvPuAncAj1/ldDLE+9pdHyswoEpJ4Ad2gKG3fhKSkTD5kbC
 kNzIwlgOSU462xv//9rpvJ6y3MxsidzEHsxJqRIDsmTj2yXbAPVXeAogQDqluZIHs9
 g+gPBO8VxFCxg==
Message-ID: <43028aa9-9c21-439c-bb23-1bc70ad63a83@denx.de>
Date: Wed, 18 Oct 2023 12:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: fastboot: add Mattijs
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
 <20231005-mattijs-usb-v1-2-7e79ab31ca49@baylibre.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231005-mattijs-usb-v1-2-7e79ab31ca49@baylibre.com>
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

On 10/5/23 15:04, Mattijs Korpershoek wrote:
> Fastboot has been marked as orphaned since 2021.
> Since I'm interested in maintaining this, assign myself.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Acked-by: Marek Vasut <marex@denx.de>
