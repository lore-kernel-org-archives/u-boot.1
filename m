Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E02C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931248382C;
	Wed,  9 Apr 2025 15:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t+78TccI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C63F8381D; Wed,  9 Apr 2025 15:46:14 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4E18382E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso7395421f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744206368; x=1744811168; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NMExAzT/jKtFN52OYE1vuQ4aVs+B2q41A7p3rvG6e3U=;
 b=t+78TccIeCvn9r2+GbahwqJdSlGHldTbhJnNi6dV392Cx5wpz864VbxWNasj+hQxPQ
 AfW1teIKALh/iGxfrgkP+F/RlNzCvBj4bFbHgTKM4rSelNlrTOnEAugbFhoFH6QFUNSI
 rKPSeSkjbE6GNPKm74xOjWd8XHloejq07mxla2UKXMI2ZsV+SM590PlyFK72ObJuPolE
 kCbqvU66q9LcSPRPRY44M0ckHEoAT2qdEySHaQStGjQK3B2AIhapG7u0R5F2DMAnChDw
 t8gfV2qdJ2HHiqqz3nRQ89Fp6CY4sTlXW156TaHdL9CEI3SMcXRVqFxYAQmuUf9GlpOR
 78aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744206368; x=1744811168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NMExAzT/jKtFN52OYE1vuQ4aVs+B2q41A7p3rvG6e3U=;
 b=hS5bZoBsKkafQ07KC1KQgiP6+RarQZIfmW1po9zU4HlMcf4Eq7IAZhQ2dLDklmP3N+
 dgP+CZs8RLseY2Paotd+tiZ+L+GEqwqPQiYHdkG5x/41vag1E12fm3uDg4NpfxgUmgye
 WUMQjYzLhMzis2ChXeJYGSqMlINvdWJfv3G4M4k35ZE8x/7ptt0pBhUXr3quxT/3vnZB
 aqS/S4xqjNclg+QXc75KaZ6bxjQTLOx9zywz7RvqsHsewZsWpkRtY0qAe1bGgakGAtFW
 sLoktEwNzCRszTX1yBI2ALZd97uMLIL9yF4SHyZJifnDO/9VvukAaeasIP8J2irht+9d
 gYmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf36tYWblo880fWPTLVwW07H6GJEJAzBCHmWaj5Q5Tri/+2gdE6kqOaLCvYGq+x595Qzp+Jv0=@lists.denx.de
X-Gm-Message-State: AOJu0YwiA3uu2dvJ+ZntuIhW33K+SIpg40HtAsaM7jUc+nV0qvywP3e+
 B8vyptl7MjRkvTOAraBgb0+6D+gAKl7UgTWWU0L7+J5QKJentZkhiiJi8TKXpQc=
X-Gm-Gg: ASbGncujrB4k0AHM1qpxFKHcLilZRDrCNscslxJL+BUGRmdKEEIShjN1/QO0OOE0TmO
 axaePXt+7Bhz/zvAfC31BzGQN73CXTJEPW8b4JNor7n3dvhPrmn+tmZ2jIhbUwt5qcqoADN4xb2
 4vBEJVBGAtXJ1BRBUelhW97PQYdP7C+hZax3DX/O96a3gIJJBsFnKV9G20Nax9vat40Jz9s8yY/
 fZTjB2N78jGlANlu0pLhZztMxXS2G8URZYChruSJ875Lj1qDc+M3bVr+DD0rdZ54eecvnnoNLoa
 X/MPxbptvI4FiWhRk/pR3LNz7qJSIMvJH3M1MIvUHtQXVTMWueiBDJJxfkKNbUdc0NY/
X-Google-Smtp-Source: AGHT+IEStYiATthJzejTsCCN5UgoezK3fowgec/HZjbDAcRO1yZyumu7JCyopJ+3dtw4+2BUxoIoKw==
X-Received: by 2002:a05:6000:2404:b0:39c:1424:1cb3 with SMTP id
 ffacd0b85a97d-39d87aa1b4cmr3087259f8f.5.1744206368187; 
 Wed, 09 Apr 2025 06:46:08 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d0fcsm20415765e9.19.2025.04.09.06.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 06:46:07 -0700 (PDT)
Message-ID: <0974a2c7-fbe0-4195-ad24-36e815ac4080@linaro.org>
Date: Wed, 9 Apr 2025 15:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Community meeting April 8th 2025 (was: Re: [ANN] U-Boot v2025.04
 released)
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20250407220011.GS5495@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407220011.GS5495@bill-the-cat>
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

Hi Everyone,

On 4/8/25 00:00, Tom Rini wrote:
> Hey all,
> 
> It's release day and here's v2025.04. We had some last minute issues
> reported, but then also resolved.  I want to thank everyone that's
> contributed to this release, not just in terms of code, but
> documentation, testing and otherwise ensuring things go as smoothly as
> they can.
> 
> In terms of a changelog,
> git log --merges v2025.04-rc5..v2025.04
> contains what I've pulled since the last RC or:
> git log --merges v2025.01..v2025.04
> for changes since the last full release. As always, more details in
> pull requests (or the tags referenced by them) will result in more
> details here.
> 
> As is becoming reguarly scheduled, we have a community meeting tomorrow
> (for me anyhow). The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> April 7th, 2025. 9am (GMT -06:00)
> 
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
> 
> The meeting can be added to your calendar via the link on
> https://www.u-boot.org/


Here are the notes from the meeting, please feel free to clarify any 
points I might have missed or gotten wrong. Thanks Tom for chairing.

# U-Boot Community meeting April 8 2025

* Tom intro: next merged into master, small delay
* Heinrich: ACPI has regular regressions due to lack of testing in CI
   * tom proposes adding another QEMU defconfig with ACPI enabled
* Heinrich: Ubuntu images being used in CI are getting too old
   * tom: has a patch to update to GCC 14
   * tom: opened an issue, Simon to investigate (link?)
   * tom: already tested new GCC/LLVM, no new warnings.
   * tom: will rebuild docker container this week, adding byacc for 
binman to enable IMX8 testing

* state of Simons patches re: bootflow/EFI/standard boot
   * issue with standard boot that the EFI bootmgr option is always at 
the top
   * heinrich: proposes a new virtual device that can be ordered anywhere
   * heinrich will investigate in the next few weeks

* tom: modernising the Makefile
   * tom: which platforms are still using old stuff? will consider 
disabling or removing boards
   * tom: e.g. watchdog (deadline 2019), legacy i2c (deadline 2022.04)

* caleb: FdtFile revival
   * context: https://github.com/systemd/systemd/issues/36835
   * would enable picking DTB matching your kernel version
   * heinrich: robh thinks we should match on compatible instead. Simon 
also agrees
   * heinrich: fine with adding this patch
   * simon: significant harm - compatible is the only right way to 
match, anything else is a workaround
   * caleb/tom: agrees in theory, but in practise this isn't what we 
witness. Having a compressed blob of all DTs would be ideal, and 
compresses well, but nobody is doing this..
   * heinrich: U-Boot is also not the only firmware, we can't expect 
EDK2 to start shipping this.
   * Ilias: Agrees, best of the bad options
   * simon: what would be the right solution?
     * caleb: have the kernel emit a file with compatible -> fdtfile 
lookups since that's faster to read
   * Bryan Brattlof: what about overlays?
     * caleb: probably you have a more vertically integrated system
     * bryan: customers want yocto and a redhat image that works ootb

* tom/simon: bloblist:
   * tom: if bloblist is enabled it MUST have the DT, set the "mandatory 
passage flag"
   * simon: OF_BLOBLIST means DT is in bloblist
   * tom: it's a bad idea to divorce standard passage handoff from 
bloblist, but if it eases some issues for now and we can revisit in a 
~year that might be best
   * ilias: we have discussed this before. doesn't think OF_BLOBLIST 
should exist, because the info is discoverable at runtime.
   * ilias: we have a standard (firmware handoff), why do we need 
another implementation?
     * tom: hoping to reconcile over time between fw handoff and bloblist
   * tom: to re-iterate what Simon said: dt should be either in 
bloblist, embedded, or discovered through board specific means. Need to 
avoid conflating consuming bloblist and creating bloblist (e.g. in SPL).
     * tom: in SPL, if we don't have a bloblist, we don't need a config 
option.
     * tom: we should remove BLOBLIST_FIXED
   * simon: we can get rid of BLOBLIST_FIXED if we have a register 
hand-off firmware (x86)
   * out of time... Tom ok to add OF_BLOBLIST if we remove 
BLOBLIST_FIXED. Hopes that in ~1 year we'll all agree that we want the 
same thing...


> 
> The merge window is formally open again. I will be merging next in to
> master shortly. The v2025.07 release is scheduled for Monday, July 7th,
> 2025 and the merge window will close and -rc1 will be released on the
> 28th of April, and then the next window will open with -rc2, two weeks
> later. The keen-eyed among you might notice that I fixed some incorrect
> -rc1 dates in the future planning section, including for this cycle.
> 
> Thanks all!
> 

-- 
Caleb (they/them)

