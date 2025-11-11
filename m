Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7092BCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 15:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E9583B95;
	Tue, 11 Nov 2025 16:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="yamBwt+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0ABB83B9D; Tue, 11 Nov 2025 16:56:30 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9F883B91
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 16:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4d5WNs29FbzyTh;
 Tue, 11 Nov 2025 17:56:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1762876589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=briBkyX9X5oBs4aVSJciQHbaG9XsZRTFef9tD/631gw=;
 b=yamBwt+DmFkRTlqzjxswmott/kC8DxXwBWGafJkloMHxcWqbzuaYoyJOlVXYheVLZqJgTs
 oyoBw1d3w/mgblrjW7MQjYW2qh+mKazRH8c4jD6hVdvWmz13GEvRY7CRavUgJY2Wm6gao5
 4jLHi2NumUuahMn5w82V2fPXbU+fm7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1762876589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=briBkyX9X5oBs4aVSJciQHbaG9XsZRTFef9tD/631gw=;
 b=UhIZKQ7/0ikGAC72hQBQzf7+1tW6WCv9PfNdezVfPYjbyNpFayyXWb1eGIVFZJcdWBsCgT
 Wz6LHfxCCVUxUrI4Kltzg5KSpriNFgAcMYR0RLMoQOMXEYj5hPIGwLUERIooCA5o2owVYo
 aNOzHN1+hX/cV1iBPIBq+Z4/E2k5+So=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762876589; a=rsa-sha256; cv=none;
 b=YwFCyCt/1OsLYumclvWlIN5AaIj4WszCpOpd5O7jC9SpeG/QJhFq1XrTHabTOrNcGNLHdP
 Lb4LlAiuPHAgCGQTZNC+650XEYBEwMVt3BxEQs3VugbLL3eLBtr3nUzrZF0kHaEQjvgREc
 QivldOKpks13rtag149xLIBjwu0D+vE=
Date: Tue, 11 Nov 2025 17:56:27 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: How to use ECDSA for signature verification?
Message-ID: <aRNcq79cr08IN5HE@kehys.lan>
References: <aO1GvGrXUw-co84_@kehys.lan> <aQ98sHenb3G1MQDi@kehys.lan>
 <DE5KUDXKQ20P.86VFM203YPJS@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DE5KUDXKQ20P.86VFM203YPJS@ti.com>
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

Hello Anshul,

Tue, Nov 11, 2025 at 09:52:51AM +0530, Anshul Dalal wrote:
>Hello Marko,
>
>On Sat Nov 8, 2025 at 10:54 PM IST, Marko Mäkelä wrote:
>> Hi all,
>>
>> I am new to u-boot, please bear with me. I got CONFIG_FIT_SIGNATURE=y to
>> work with the RSA algorithm, but not with ECDSA.
>>
>> My two main questions are:
>>
>> Is CONFIG_ECDSA_VERIFY only implemented for the two targets:
>> rom_api_ops in arch/arm/mach-stm32mp/ecdsa_romapi.c
>> cptra_ecdsa_ops in drivers/crypto/aspeed/cptra_ecdsa.c.
>>
>
>Yes, those two seem to be the only one's implementing UCLASS_ECDSA.
>
>> Is it feasible to support something more modern than RSA signatures on a
>> reasonably high-end target, such as ARMv8? Are there any suggestions or
>> git commits that you would suggest as a reference?
>>
>
>Should be possible, you can look at the current implementaitons of RSA
>and lib/ecdsa/ecdsa-libcrypto.c for reference.

Thank you. I will look at that.

[snip]

>> Rebuilding with CONFIG_ECDSA_VERIFY=y changed the error message to 
>> the
>> following:
>>
>> sha256,ecdsa256:dev-  error!
>> Verification failed for '<NULL>' hash node in 'conf-1' config node
>> Failed to verify required signature 'dev'
>>
>
>This is probably due to U-Boot failing to find a driver with
>UCLASS_ECDSA, you can verify by adding a "#define DEBUG" to the top of
>lib/ecdsa/ecdsa-verify.c and check if the following error shows up:
>
>	ECDSA: Could not find ECDSA implementation: -19

Thank you for the tip. So, the #define DEBUG would enable the debug() 
statements. This indeed confirms my hypothesis:

## Executing script at 90000000
sha256,ecdsa256:devECDSA: Could not find ECDSA implementation: -19
-  error!
Verification failed for '<NULL>' hash node in 'conf-1' config node
Failed to verify required signature 'dev'
Boot failed (err=1)

I'm working on this on a hobby basis for now, and it may take some time 
before I will submit any patches for review.

Best regards,

	Marko
