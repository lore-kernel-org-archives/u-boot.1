Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D49CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A2F878F3;
	Mon,  4 Dec 2023 09:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701679722;
	bh=IoeDse5drLOtV9tZg+3k336DSDqI1cmSWBsYiAYr+aE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dNd/epsUDbhTICz2/kZtTnr/vnOuBDCVdvLnJ+AnuViMYpiXvGuHgdwoKtIptAAjy
	 hQ1DxnINgVvcrl7A03ToJWTo9yUqYkODiF3Wj6EE5V/bqYX+Acgr7XqYe9xsikrUq5
	 7KyLQy9kLV0P2mLgCPe6OZbUgsFakGYCQxBxh7sOcc2z9lhlmnlnOSdv6w23Pkx4Kj
	 2ud3uHZ4VW9bzMOL9EuA1k2Ck7JsYcmNGV2GHVFpJpenZojYRP5tFsHp551trYXpaU
	 w6uRUrG/BLCzskQhGX6BCimBbu5vA9iqDYfbZ20pc0v4hJRuQdrFR4Wiqi9bZl299f
	 HU4YkLgvJGdiw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 11A2787905;
 Mon,  4 Dec 2023 09:48:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701679720;
 bh=IoeDse5drLOtV9tZg+3k336DSDqI1cmSWBsYiAYr+aE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RIdRGuH74qMjEWu6kQLRk4dvxXmreUvO4Ok6Bmfbx+cDpAf5Q3GMoHhwBDE8pYvAY
 1JnNV5TWNf9zDeWhUwqZGX9jqjxvIRD1SWN8g8AEGHihK4ffcjPaTI66fs0E9DGArK
 beTaVa5dxTrbqbgyl6/h6Yi0TYGURKJZOoIiBftrL1+rqCA2V6okHEiZ0ooDysBilF
 d62pg148Ye287YRx68a8TfePAsr96YJZGgmPzWpuIAYW68STjCYbMw3g+xane2Sdhi
 J5+cFPvTvYnMNznTnYjSJW92yv8CYbp+fE2+SxSwfRO7ct6xqb5pjVoCBXX+mgQ2Oz
 HFfuJNoKo9vNg==
Message-ID: <26e9c48f-edfd-44cf-9390-435d3c1d7e0f@denx.de>
Date: Mon, 4 Dec 2023 09:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
Content-Language: en-US
To: Alessandro Rubini <rubini@gnudd.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, rogan@dawes.za.net
References: <a9f1fbe8-d604-4df0-b390-2be147bdd965@denx.de>
 <e7b025bd-3498-4899-a73e-c55ff7a81f7a@denx.de>
 <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
 <CAOMZO5Ajq2L9-pNLqq0JGUmWdn5Lw=SeQsoZZ1YNYJbC1gJZQQ@mail.gmail.com>
 <ZW2JNHXCeO+Szif6@arcana.i.gnudd.com> <ZW2Q9quBCfffClG7@arcana.i.gnudd.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZW2Q9quBCfffClG7@arcana.i.gnudd.com>
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

On 12/4/23 09:42, Alessandro Rubini wrote:
>> But what about the bad block markers , do they get erased when you write
>> this U-Boot image into the NAND ?
> 
> The image includes OOB data, because the rom-mandated map is different
> from normal standards. If OOB is zeroed, blocks appear as bad (correctly!).
> 
> By memsetting to 0xff, before filling data structures and checksums, we
> get a binary that written with "nand write.raw" works properly (the rom
> is happy with the format and boots) but doesn't mark blocks as bad.

Clearly my recollection of the MXS is not what it once was.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
