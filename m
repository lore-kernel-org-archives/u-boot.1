Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70B1F5A8A6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 18:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B3284348;
	Mon, 20 Apr 2026 20:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="Eg9H4Vsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EAC884353; Mon, 20 Apr 2026 20:20:40 +0200 (CEST)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C0F842BF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 20:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzv1D0yzcz49Px3;
 Mon, 20 Apr 2026 21:20:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1776709232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bg8AdpsZ0iNHKGlup1N/dvqjJ+ruGmU4grRXk5zNa/w=;
 b=Eg9H4VsqnwkOvqlZIBjhg5Gt/Ng3wIsyNxrfB9b27MgZB4qQf1jAY5ZFTFoj8Zc9QOQ8Ux
 watIF6nwPWahChJbJz+b0yRbEDn65k+ZWzgYNT2uTSjzqrqOongiMG/OLhyPcDAyTCuosw
 OuaYoYN3q543F7GFtI8jMXq6UVKCecXOLgKbBrX2K732yj87KhD6ejATK2fHf5mVlF3gBk
 EO60kJA38hq0+7sTX5Db6OZKcO89+60rs6EpAS6QocrsGCC2dslkc4p4yfF2Xg/3lLGzWa
 ODLBEy7GNKl3S2yHfwVJA7OvUwbgzeFuMCCJF73isjjK/tyad4z8yt6+/p3HTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1776709232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bg8AdpsZ0iNHKGlup1N/dvqjJ+ruGmU4grRXk5zNa/w=;
 b=ZTjoHnVkPV3RzOwtOR33bTNjKOVKDNQ+MGcwh0edzWlcQAwP+uoDBCUjlBElx5uK5om7vy
 Thfs6lwUG2UhJUUAtMpjGJICoZYOzVN4yYBTQ8hcBeBwO4OPtCsNyc5hWja5xLGLHnxd4h
 MORthKgZTweRYtXQ1qOqWIZgGRS9PYY3SCeqoDu2RuHXKaINgomxn7Mz+q9HvqLxL2EpAg
 t0dpxHQ5D4VFjbge50cTcAZZ8mWeee3sGOd2+isSwE6abRHvFn7Y/38o3DQpWe72F7LFYs
 riqPXzyhSdTl5ke43X3Y9CZlf20H9FrhGzKNwinEhPQ1dN036t9gndSP5nFCrw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776709232;
 b=ZzsyYq0I3FQb9PiBdnEHlYOW2hdR5ShkMqOqx/k7zwxex/N2cdch47xdS0SGGqqLYDT4Iz
 utZgLUqwaudgqNnBJsGjQWw+RLFFzA+gfNd+g7QvkjaGynFWU6a+ykkDHZd87BJHkFd1YF
 5uNcXYZZYJRKLdggH0TBTxjJD80xkQOB/Qv6dQVxIY2yFcbIWuS7A+TJJSsOvUZhKxa3ph
 3V/s3uKLmqa0Qm4hHt1RCwzglM+MWThbbcvQyliTF2RE6v1sRn03VKNFBtEElj0dDCfqta
 ibmp8bejdFFFPcFbY49GLdVwq5mfxw2nG0lvZoFmaxPSEp0LIcRrCVE9K/0ztA==
Date: Mon, 20 Apr 2026 21:20:30 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <aeZubllYVLLpznWr@kehys.lan>
References: <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com> <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
 <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
 <aeOdF46Ny1AfNsMi@kehys.lan>
 <CAOCHtYguNVs+epQH8Lf80MXRJj-udsRfEuQO0LRO0cvG4HhKZw@mail.gmail.com>
 <aeTeiZER1IJar_w6@kehys.lan>
 <CAOCHtYin=6r86ThsagZrdFu5+_b2ACGmMZs3yK3tPd45PXJw4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCHtYin=6r86ThsagZrdFu5+_b2ACGmMZs3yK3tPd45PXJw4w@mail.gmail.com>
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

Sun, Apr 19, 2026 at 10:08:56AM -0500, Robert Nelson wrote:
>On Sun, Apr 19, 2026 at 8:54 AM Marko Mäkelä <marko.makela@iki.fi> wrote:
>>
>> Hi Robert,
>>
>> Sat, Apr 18, 2026 at 12:53:59PM -0500, Robert Nelson wrote:
>> >Please don't upgrade to the 12.x.y.z0 branch of ti-linux-firmware
>> >
>> >After this commit you can't even upgrade to `v11.02.09` without other changes!
>> >
>> >https://github.com/u-boot/u-boot/commit/7403d26bea36315f2008ed3ef80125b094c0bafb
>>
>> I downgraded to firmware 11.2.5 "Fancy Rat", but that didn't allow me to
>> see any further messages.
>>
>> >I'm pretty sure OpTee 4.10.0 is safe, but otherwise this is my current
>> >stable branch:
>> >
>> >https://github.com/beagleboard/u-boot-pocketbeagle2/blob/main/version.sh
>>
>> I tried to choose the same versions: OPTEE 4.9.0, TI-firmware 11.02.11
>> (strangely, also this one identifies as 11.2.5; I should always build
>> everything from the scratch), and TrustedFirmware-A v2.14.0 a.k.a.
>> lts-v2.14.0, because I did not find any tag for v2.14.1. The U-boot fork
>> that I'm trying to build is already the same one. The boot process would
>> seem to always hang at the same spot: before switching to the 64-bit
>> u-boot.
>
>it's showing up in this repo
>
>https://github.com/TrustedFirmware-A/trusted-firmware-a/tags

Thank you. Somehow I was missing the tag:

Fetching origin
 From https://git.trustedfirmware.org/TF-A/trusted-firmware-a
  * [new tag]             lts-v2.14.1 -> lts-v2.14.1

Replacing the TF-A didn't make a difference either. I guess I will 
switch to another (non-trusted-firmware) development platform until a 
revised update is available.

	Marko
