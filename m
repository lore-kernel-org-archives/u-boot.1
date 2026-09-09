Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E121C79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3216240633;
	Wed,  9 Sep 2026 09:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OuMkKxG4ZZK; Wed,  9 Sep 2026 09:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 60B2C406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788944710;
	b=mORv6tcX6+dXfXdN2q5/LRDjup2kiYzttzgHHu2704oyw/j9ugKJj9FlozL9VLStjRJp
	 nS2m4/+e17LcAQ0R1nv1rQhvrIwgjNB4xd8j8O6SbqFykpPvajN0jM8ZS/ixDApAiyu+2
	 UlUmVIZ7dl4au6YNfrHOvt3gA/S1UvP1FHs7XvDVj0JWvTDZbHno8HwKLGzZmxkZlPkJL
	 05eLAqO2GW7CoewrcSWMqklXXZkH1soihNbvcF7vF4e/JValpWmt1LKCBjFLDJfZ2BlGu
	 D9mHlwEyon+BFiEpgibUEjhS0a7o3XfNVH2cou5HUGmKuhF+GA8e6nzGkwbEch/MB5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788944710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Eskoa8txNCY4qXRZkcbIl8o9bAMYPUECZHe+crJbPCk=;
	b=oa4OBFCjRZyj+kWAoSpqp0m7TsztRgyuV+jnUeXiNMZ6Bknes2dIx3J6fnLBJ8faNoGS
	 YNNzzKnuzMX2Kb/mHO8bqPYQ0rjvClgNkRLK41KSMdmGXC9fBUku8S7nxXUzNHvCKSiQE
	 FeoTyyb/qjvtYwzghjpEqSqO9Oqatno22eMTaLDfonUhzoTZ8Fm4HiQvF3zzVm2+pmZ6N
	 obTuWQy8SML0358UsUSFMcxVWIbC1W4DIdximaSgk+iHFGtZRs6ZAtnDLsHvfOyXZD/bv
	 qOk0LsNVLNvvvvAkNTI2UjIbWDgJ4OFQLUqSqvAVm6yn6UiXbZocYp1RklJ3CGFtWSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788944710;
	bh=Eskoa8txNCY4qXRZkcbIl8o9bAMYPUECZHe+crJbPCk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0QBu3KL0FHVWCNoK5o4EV106ucOJLcmR8wsJwCPA2M/yPlESNQHeBjj1ecNo9CN0Y
	 rdK0mmsTGLPT/l1S5MNOO5gNKhIq9vtKWAIFbizaw5od5+S6gtLkFc0Nt6Ixok4Kc3
	 q7R/B6XIUscFDQuHvuk6L3cis1Myb74U9TkfAm/SJfav1vXVziLBa0jVKvnsuc86Of
	 lJYqRTfRqL8u2UbhvVSckFPaH0Vzn3q5UH3lG0AYzvgv2Xu0JSegb7pNBBDL1EbaPm
	 OFu1+Hy48KMtAGlIwtzNeuX98qlXkbI3yAGJnA3fdQKw4EyMPaciwwbUkyw0rAHM6y
	 /qLyW2sXeAdDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60B2C406C3;
	Wed,  9 Sep 2026 09:05:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E7E742D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDCE8606C4
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocBsqVE5bUzo for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EE34360626
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944709;
 b=IAAEpQIWOJoCEFUGi3VoU4QbhPYxTq/A34KsN9nUQWVLf/DWp60LkdJLEtqQpVfJ0VzG
 AA230BrHRULIFR/DrZ8zNGVyBTJStqgnpV8U2rgnBX2Gdb75vG5DfW+MsDRnFLBggrlCH
 zPk1p16tWbsV91+ig06P1f1GgYndIWqyUzgefSL4vnHFQ4mhpybcziTI+LxRu6YqkaLwz
 aCxYzzwg8CRHBOeBO2gZmF7J19UkMVOWpwTmft6ZQWJFk0yhCdGmHYJ9HJ6jTVn6M5R34
 efqD2xP8HTHiPR+STtenZAEfLtVFy527OZfTtl6YDMSjVxggWRYCWM4OOnADYpilsfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944709;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Eskoa8txNCY4qXRZkcbIl8o9bAMYPUECZHe+crJbPCk=;
 b=EuuMZFS7dcfOhP7bjPz5wQqWGaofHH2WqJxXI47n7pgsZM433JHF9Ool3Lj7FvNy5kbJ
 xR9fU6i0A1ckreVBlfJVf6mC9JUs05RbYQ132eZcoTdd/7I+dML0tziZpql3DxTdlVf+b
 P6AWZTijyMizrBjYb6aE95zj3uKZSPk4RyNebqIYDQh/E3VwKJjgz1P4PUgDt2lGzzoC4
 qgrcmzbRhMS4ND7rB96Gr3IqhLsS/vAWNn22RfD/sRifswehvApM5KxWeLnz0kfczakxX
 CKkvZhxngtg1/b6qGr0s/N3MrrMhEVFj4qMIA6PFLtn2q6AB68Sp2Glq/HPymrol2Iw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="jit6d05/"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jit6d05/
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE34360626
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:05:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA36860211;
 Wed,  9 Sep 2026 09:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05C21F00A3A;
 Wed,  9 Sep 2026 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788944706;
 bh=Eskoa8txNCY4qXRZkcbIl8o9bAMYPUECZHe+crJbPCk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=jit6d05/cKKR06WlANmYmL4s/ZD9MygDSxv2KvZDP8uVmhJYIZfZ54dNmPH7yEDHb
 IbFro3KF9LWgDc4OZ0imhIV6g54kibxC3R1iTIbgP68M4H5AZiWzPtalL4XjBvLsgB
 f1Q/+FqhaV3URuzRVD6lpKoXW6XkwvyG+fe3vJzEXiqsS6P7omj1QhFPu5k3UKutHw
 tk605L+EFqsPIDrq+kPraOT4/kjpsK1sjy/msjjZjfa/R/2xLY6dXKAjDoiou+U1+s
 gqBB1pdzDHndAxi09KNaM+7UCHpxcqhJceShazeXvj9d5LKD3cZxZXPukE9NzBEfmh
 3j/Tmuw9z8f4g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: igor.opaniuk@gmail.com, trini@konsulko.com, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
References: <ya4gsjjicokwdqwvqwdoho6cf2iwo2ecrgvmfoappavszwml2l@tnxffaphc74s>
Subject: Re: [PATCH] avb: fix missing break in avb_set_state() switch
Message-Id: <178894470401.129147.1977335287778779987.b4-ty@b4>
Date: Wed, 09 Sep 2026 11:05:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

On Tue, 01 Sep 2026 15:49:24 +0530, Naveen Kumar Chaudhary wrote:
> The AVB_ORANGE case fell through into AVB_RED due to a missing break.
> It happened to be harmless since AVB_RED only breaks, but it trips
> -Wimplicit-fallthrough and is fragile against future changes. Add the
> missing break.

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] avb: fix missing break in avb_set_state() switch
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/0802a621ffe504742458af95ffa79e161047a148

--
Mattijs
