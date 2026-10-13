Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB2CCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 09:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E77D860751;
	Tue, 13 Oct 2026 09:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqHWd4Sl6i8s; Tue, 13 Oct 2026 09:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2A9260693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791884701;
	b=i1SRz5cIFNlYoVgTRA6pZ9dhKpeZBjJ9iobbHjbYK/BnpHNnIWQ4RVqEDuUPdw/v6WNY
	 jq+Gvlozi4KTdT1KOnN1TlRXamNkmisCVyCcH3PwTGgkbjI+haYHFQPJt+Ors4QXBVime
	 XE/vB9NwGZHzIXGYcJFqG1o6R9Xcv8D1v+8+1Km8ZgCB1JRRRGGed7Xt9Qw+I5AUzDAfk
	 Pbt9zKumRODta/ooeGKnNDsX7aY7tl3i5f767xT1asI3VJMUhfnroyJ8qtOMVCGqryL0E
	 2+caGrxne9ynR2pBIo8rIknVAhSyIqtW7RUiFG6Vfs71dA2uqmKhdbDgjO0mIZNcFRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791884701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YX0v6coLzZMTjxH8asmNU0veahDytGWYu/rrEJJdSlU=;
	b=MSesiUtteoYgsoyqvwvaTdNvE9Dki4UAMVkYPNkqnZj2r9ZsM/9oKvpWYloXXWCSeV+I
	 yeYwSyGQBvwhmyWbA6Ss16aJd9zZdsb8ds7JpueEWG3vCN6KrSgTSBcV6p+X7m14ZOcGb
	 kFDmGkdBko6xJnEzZcWcjkXjBhoadptB/yyzsGyZIKy0T8OwbuaJjpgT7kqRkrmbDPD4X
	 PdfkQKJ8iX7OUajAdA53phIXBXCxQqNJk741/du7EwA9xeBX3VnhIexWOk8y2VtVxHEng
	 8IFRHSzRFDOzqEG4HWyLgDFbJqYPnoApbyDZB2uWKCiQXWbA5F55HkSUPe//0cT0Sog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnO+Ahvm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791884701;
	bh=YX0v6coLzZMTjxH8asmNU0veahDytGWYu/rrEJJdSlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sj9ytdwXoqKvjPer7pKNoZSsbRKHH0ya5zVUBt2NBo9/3pfWLkkHL+D+gCzzY2K59
	 ZwK3J3l91OA3IZR7AAYBCv3Aa7G79q+L7/sQA/6rkRaLC6ADD9nbzyGxqbYGAEusR9
	 47sAS10ZD3FDEG5dVWYrfwLuni4bzvW4TW5yj08OgR4A1dv4dX9AwbnMLiC1+onFmx
	 4c7n3GYyaWtaPxHK12G40+FrkPQuujJvph4sDmhgGmesXQ0u4PukV4z2foRHL6vsD2
	 Z4Oj45SjGI4WsdU0dUIkhdAu3iv4cs1jet8izIzZHJmen6BsQhiawXz2t5Br/6yVik
	 VZAYevEr1+F0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A9260693;
	Tue, 13 Oct 2026 09:45:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 628F2235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F2B760693
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGMht1z_ySFH for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 09:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A47C60629
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791884696;
 b=hOEJPD+ZEf8FinBt7FIhhOaxOM+MzrD7fG0LqQ9udZLbf1ZBzUDiRwiYcXPWLvChN1Lq
 qaWP4PQqzCvFnwJEBRhY092rxIwwLMOP0RCVfp5JJ39RsdMkrTR7a4igq6FPRwN5EIN/S
 UpXJqZZ2rLgCJ+mULHjuZHKYr+lp9SIRpDgpz0qkVX2Y9IBZkKDZnFY+mpOYadr8Ynru4
 aBpAzPrugg64uz0mAkWGM1X9YHX0ViBMvLe+u0DvtPA80Qp4c2BvtaKERwYtr6wKTDCnA
 6T/mdUYj5+29ctP5N8r4XUp2AONRUXSyGvA9n/vNfGhQ35H4uSY9vM2ebxmvcNuruAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791884696;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=YX0v6coLzZMTjxH8asmNU0veahDytGWYu/rrEJJdSlU=;
 b=rtZ7yNRg7YnO/nSB0ZNsJOu49Hvdg8ALcY2l8r3XPyVNa3jkcGJRDiP7b2ab3lO2Z0qm
 kMvVBBH61PAhSkMSoUSg272NtybN3FqNuysdSVhierzYSBzOKcjuCwUdhk8m/7OJieS/E
 XGosALAMrZqa9G+uMXid8W9PaiTvJna6whX8Rf3RYeqFiSXWJL8ODnHhDWy2sTScBG4xF
 O6rQTwzY7ozo8LC+Mi6FPu2ugWYDTJnCp1N2Oi07eOf+EUopzTFUt6k4srJTvylCm5DoZ
 uRh721EHRsxjbaoEHBnQoklPa+NAWQWyVI1tzQYPZNu+mGgRfhfCQ6aBO2NceVlq2pg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nnO+Ahvm; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nnO+Ahvm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A47C60629
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 09:44:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEB69600D1;
 Tue, 13 Oct 2026 09:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319781F000FF;
 Tue, 13 Oct 2026 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791884690;
 bh=YX0v6coLzZMTjxH8asmNU0veahDytGWYu/rrEJJdSlU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=nnO+Ahvm8Z2Y/zNtt658PsAlv/ec+POmkt+7sCMbTbTXP1IujaCpSiNWF0UAqfc1k
 0U1yiSilx03cKRM45pbbCm7GUWLldLys9E1Pv+T7/fGW/3xdwKdjCAjGcS5Fua98ee
 N7s/sYzrPy9556QiEyuXAPcIYC22U6gaoop36blZm7BpwghI6GrPkpUwkbcq9s9Mi6
 1WSApEaYy+zs0leAORQh/OACx07gi56ZoslhkQdSaYGGJD9o+pUSqyJBlcnBSS1Or7
 lghtuQoahdxQbBxtAWzy5JbhesoKw1cwPQhixGkshZ2kIvlSAiuUnHt5t+OsjYPOIP
 S4ZT8om+6ZGeg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org, Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
In-Reply-To: <179146357781.183177.17223915816731601716.b4-ty@b4>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
 <179146357781.183177.17223915816731601716.b4-ty@b4>
Date: Tue, 13 Oct 2026 11:44:48 +0200
Message-ID: <xhkdb1p9u7x4f.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

On Thu, Oct 08, 2026 at 14:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
>
> On Fri, 25 Sep 2026 15:42:23 +0200, Guillaume La Roque wrote:
>> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
>> A/B images used by these Khadas development boards. Remove the unused
>> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
>> partition layout and correct the DTB indices in vendor_boot.
>> 
>> The layout follows the AOSP generic boot and vendor_boot model:
>> https://source.android.com/docs/core/architecture/partitions/generic-boot
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)
>
> [1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2d0134bfc140b9b2092ab09cfef37a7da7c51ac
> [2/4] configs: khadas-vim3: enlarge the fastboot buffer
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/349d13ce42f60dba1604accc3abb24d5f6afeb18
> [3/4] configs: khadas-vim3: update the Android partition layout
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09aee880eea6cf05e117988da1be8231b07c5bc0
> [4/4] configs: khadas-vim3: fix the Android DTB index
>       https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7a403d3db56db9f1efba44ed145e875c23fb785d

I see that the patches have been applied to git.u-boot-project.org [1]
but the b4 ty note still lists source.denx.de.

Can you consider updating your b4.thanks-treename and
b4.thanks-commit-url-mask so that it points the new instance?

FWIW, this is what I added to my ~/.gitconfig for DFU:

 [b4]
-    thanks-commit-url-mask = https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/%.40s
+    thanks-commit-url-mask = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/%.40s
     thanks-am-template = /home/mkorpershoek/.dotfiles-private/u-boot-dfu/thanks-am-template
-    thanks-treename = https://source.denx.de/u-boot/custodians/u-boot-dfu
+    thanks-treename = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu

Thanks!
Mattijs

[1] https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-amlogic/-/tree/u-boot-amlogic-next?ref_type=heads

>
> -- 
> Neil
