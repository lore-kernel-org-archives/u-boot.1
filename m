Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE79C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138AE88901;
	Tue, 13 Aug 2024 06:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522205;
	bh=6WN6uW7Qy1xzwMObwGOIawk8dPS5skiFxrFDI08Hz7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=o5By0JkZTAFE912OTnhFjxZwDUtru1L5qhJ/qOvyZD89YZhnZZTAKPcnqAQXiZllM
	 DwKIdorFcHjSUhEHixYSFtsNoGK2zpTFaGgETSpzYeCeSJ4QWyhm8wXweKy33d21My
	 0HoiJYcQEdACgjEYyv4NmJqeYOyrEY+WRYQFF4OPhd+SvaFp3GnAGbEnWSGTrNA2Ip
	 4XjACLxIo3dhC32RP9MCBH3ZT1f2A9USvQOlDj4ONJo5Ypnzm4T+yNSEhJ5Z7V1RfG
	 ljkzxHqtDaz1qoD3Q27rS2ARRky7gYZ9UCyj4sSrovOb6p4AOMdlNF1d9AGVcXK+L/
	 U0vNWETRy5j9w==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1A8BB87E30;
 Tue, 13 Aug 2024 06:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522203;
 bh=6WN6uW7Qy1xzwMObwGOIawk8dPS5skiFxrFDI08Hz7c=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=y3fcChmfVtjY7yQyLSDP003i9QerOEE+GtrYWK8lgKbZbz6EOMNhc2qc4aOq7OCVY
 WiiV9vibAzIuqmhN9OmmzDaGWuImwaBd5WrPRy2+qlRGWQfhturXLIaOmqK/Y8sO36
 QH7x+k66Kn5qQWbYG7AEjgTF540kv+w6R1+7iJxaZpdNDfC+BQC8bZYeQwEb/FMfvI
 qlLZLqEwoqldQqVZWMVeN9oL/W4aSlMhR53lUgOobO2KaDTkSTcHS4rP8yBsuLMYw+
 EXkOmoFPQIF6O2c3qrm99HVi+R3mSkytByHw7jgZuITCWx5cRe/p4pIHTPhmXnUdaZ
 CoadfWyhGekJw==
Message-ID: <4ad45745-700e-602d-6008-20ec634d485a@denx.de>
Date: Tue, 13 Aug 2024 06:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 07/18] MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-8-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-8-sjg@chromium.org>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> These use pre-driver model code and it is several years since the
> migration deadline. Disable the 'date' command so that this old code can
> be removed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   configs/MPC837XERDB_defconfig | 1 -
>   configs/ethernut5_defconfig   | 1 -
>   configs/work_92105_defconfig  | 1 -
>   3 files changed, 3 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
