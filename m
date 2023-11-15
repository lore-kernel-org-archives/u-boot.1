Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703D1C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2B18718B;
	Wed, 15 Nov 2023 16:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700062969;
	bh=DD+bOEwLKSQJ6Ji5fNRL75Ba3TJyY2n4Bpy69A6xKek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ovvFxXWblAzJ1ZqoUCFyMX414+Fmlwg4eCrY/qit0Eimqha5XVLyAdNVVempLmEpQ
	 aAkN/oGNIFbi7ZdtppJRtSs1S64FeIoZITalJ6PiRI398cmhx+zmOBe9hBHZmouWO+
	 v8fdhNslvs6yJSRNmYJPOCzQEcMRJZRU3VArW+Spf6yBuseGEGiSs2HvUEBqRYwIRX
	 0Hr25NBqAPQJBaa17cKbWSd8ucrRXqcdoHgNIq/YG4+jJwmVJWZG/IFovSuSBtOONl
	 GeRHcuQUpTeRhLIAOyVZTl9I/LPvN4K2M7SH6p2VqXAYQnwt9sVx3kJ3nHi/GyGJfe
	 LTbQKSfk8wUdw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D672286335;
 Wed, 15 Nov 2023 16:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700062969;
 bh=DD+bOEwLKSQJ6Ji5fNRL75Ba3TJyY2n4Bpy69A6xKek=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o6Plxu1B01IBpsOGVtDx06buMOrd8VsVZVY77Ciel3qEsw0zdYTnKfNxFdK7o5d5T
 iIlyZt2AmhIftlnjlasolg6mESlNfgXFMNPeQAnFHuASazDuciocn+2yG8AGTxsQlM
 Q3O+CzONPiurPH2QXSPrf4SKoyv/20xkuFg+3T2dLhm3ZmW9GQKWxuwCIFkbHlnuaf
 JjHerm3dnpuIeY9yA5/TXhRymoi5hDwRTjScw9GMCJfeaXHjJUyw9i4XoH6L/Szy1g
 1fCFyqtHxVZC62jd91lUrCmbyIK2jRk2a+zIsx+/GXc0jy/dLIirmhbRrI/mn/y6O4
 KPJIwvEubWlpw==
Message-ID: <286a2dc7-e227-40b0-92fa-4451e98c907f@denx.de>
Date: Wed, 15 Nov 2023 16:42:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, trini@konsulko.com, 
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com
References: <20231110141311.512334-1-i@shantur.com>
 <CABEcMwUxM9hPh1c=Q8THxkJUqzw7fT-bWsdeuJoyZ8vN6BaCkQ@mail.gmail.com>
 <CABEcMwWjHxNTE5wVkgaQXRBwt2WP-uE3qgRpNrqiXFCjHD2iZA@mail.gmail.com>
 <77937c9c-4f00-4721-adb1-5bc8b570c6eb@denx.de>
 <CAHc5_t1cOgJQU=LtSc_zx0UY_Z40VzOSWNgXYfS_PAFuxKhpsQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHc5_t1cOgJQU=LtSc_zx0UY_Z40VzOSWNgXYfS_PAFuxKhpsQ@mail.gmail.com>
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

On 11/15/23 09:26, Shantur Rathore wrote:
> Hi Marek,

Hi,

>> What is the point of this growing CC list ?
> 
> Apologies, this is my first time with email based patch management.
> I was reading articles on best practices and first one mentioned to cc
> people with recent commits,
> second one mentioned to use get_maintainer script to cc people and
> hence multiple emails.

No worries, I'll have a look in a couple of days, sorry for the delay.
