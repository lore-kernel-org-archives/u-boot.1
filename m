Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83EECC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5008540554;
	Tue, 13 Oct 2026 15:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHX6thIdYAaI; Tue, 13 Oct 2026 15:23:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE5BA404D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791905039;
	b=jw2xeMOJYlejsktMiWStfOdpQER0+TC8hBfZGixSrStyvjzGN41C74hBUIsKD1JOi0Ni
	 9FAgL57/WcgI1E9WN5FiwU3DT8OI7LrqGJwyfpYtnFL36o6Ppfc3oY0/XSwyTYrz21nBa
	 uucuZ8SW7UYCBKsrCk2jfOkwWxy2uK+9rN0M6pWdtisReqnaDyr1oYdb20vb8Mg+s68oy
	 JLHjrp045c+PuLfAUE+f7f95QSX2G99IrAj5XK1NaRUEenQF7x3Ak8JjRxx6TrqiQ0hgP
	 GuNT/Uh8XJx+5lt/XxaGKnOBMPFJpR4qsmE512C1c4wDlqMwspBaCf4F5551VYAuMnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791905039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=axJqpFZ2liKgsoMhx8/kY24bE1rH2K+zID//2R7VncI=;
	b=bKcZwyvvFsQIM+WCnVNBz1jfSWf6R32EauzAMc+wDk+UvrvBew8FtmZ+10mvWRmZQG89
	 kelJVdRrhCt5C9/NsKoWXwRiffqwQm6zsPI0U7W+u7oqA9wFCtjcv6ZWKv4JoAe0Zsl1I
	 GJhyOiirpqee+F7hfqV3Jvq6tOzX4gWYOsPTXQ1icKi4qzrYYywRO7jNLR7flRXM+G27H
	 gQi4KIlKSGtpZylhsAOWueaQKy6veAjPp778nkZYXdC31d5rdXDPLarEQlhgGUj12apn7
	 vSPTMvPUsa274VHKrnsCGA4puWvox/Bslz62d0NS4rFXtayWmGwJIoomJqpdEIsvong==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791905039;
	bh=axJqpFZ2liKgsoMhx8/kY24bE1rH2K+zID//2R7VncI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R00RnaWpUCGWMqAtPAKFNBJxO14CP/OQsl6Mpdfvxx4XUpy/C50iUexRBeoopAF9G
	 8HJfhOrIE00pZFkrvrx9lJnPoQSQCqugvgKE6a7l8aWtYw3kKEE5o+kfI5YsgTkx6Q
	 dy5hIC1ZSCzINv8DEbfV9X7oU8fnOJWyJD/fJPxXSrJxOy11DWIeJToDuUkpxo+swZ
	 3f+BjdnVh1K7vbb6Ai5iUuQofvbF2AVdwO6KP5xgBc8dqLuKZwKDSTYTJTYdvLI8yp
	 7+Gq1t1HwAiGMu1g5Ek5odwDXznR699yhyBy4pyPGOLp7FQwC4Ea8xyCpJKleaXlGE
	 xfDYGgzdNTKWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE5BA404D0;
	Tue, 13 Oct 2026 15:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3857475
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E8D1605E8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ayQSRHd4npHX for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43C30605E5
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791905036;
 b=TjZbnEg/UnHBJXY07A2k3ATpllvq7PgLXyq6XHcXfN0l05UEGWi1buhWY87uZsU3kT/F
 bg0Pw/WPIyHVvgz4pQ/wEtabFmRRaDCF9MWSIL/e+olIoR8Mas04rDbIfCElAnGAxPBiX
 4/rQ/PoJ9gFK/cONtxbna0jof12lmCzzZ1x/QyMUqkEnKnlwqq48gBjq8XUT50nAbqBTE
 EA6URitRnCq45vDfwufXLJJ0GBK1StTIQHCXxi7uioMar+4Nwxl1Ye4Di/zxElwn4uqOA
 UGU6/qzk0xYcOtE8Q3XSnJunXamnHeRGKGW/qoTI85YaVtdlFEfQnC3WYoSxnJVTkew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791905036;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=axJqpFZ2liKgsoMhx8/kY24bE1rH2K+zID//2R7VncI=;
 b=i4XEvByY+vpIFPckRczHo/fHrN/MVJO1lEAgQtdF87FQF/ARmA/LJ2h1Exa8OLowLbT8
 AK5H5K7s/ph93TRq6HYYDf+IwswoZojb6JcBiDCgryNoDCvJIXnkgEkx/XHMBJsOzVi4b
 bbm1W/gqrYr+pjx/2OaaFEdByzSpSuJ+WqA/6DqjzUgacEnVjNU0en3nseSE5XOsVEl9Z
 CnIJ0R4sq2XHLI0mrybxh7XqFR8kiIcvLlUJ5KrYulIaq7I+mWHvy2HXzzV4a7ezDiC/u
 KwokITq4q8zCAaYjgXsDMW+OUZXQdNnHdtUuvxF15IMK3gapoV+UW7g3LSUm9uvWzCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T7G59nis; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=T7G59nis
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43C30605E5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:23:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89F0D60A52;
 Tue, 13 Oct 2026 15:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D321F000FF;
 Tue, 13 Oct 2026 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791905034;
 bh=axJqpFZ2liKgsoMhx8/kY24bE1rH2K+zID//2R7VncI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=T7G59nisSN7/Cb9xl/1SQ45v1psdwSJwXCFeG0k/wdr8QBjoMx7zQYE6L1aMEk1Wq
 oqPEfY5cgb7LkfP5JIN9W01gLp3tU6zvrYE1sY+s4VgDw1W7H+1YGBItUggTIxlwfE
 Brd45zNbbOc4Vdx8VofKNmvPZoAKrYPs3K9nsmpEXnO0d0OtjNEzfz8Gq4tRZxt+x4
 8UEZOS7QvLt3UIFZXSQJg0iN1VGmEN0muxAjsxa6NlUP/x47N7lcQ2oNmwzcB5AX+c
 afjX4pJGN6BfArg8AuzcRGv1+mQEFN9nXK+FFW1baf9I4n72INH9hRBRILUcizpHdM
 raioyBiPtZ+dQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
Subject: Re: (subset) [PATCH 0/2] usb: gdaget: f_mass_storage: various
 fixes
Message-Id: <179190503194.329744.16054507872379707959.b4-ty@kernel.org>
Date: Tue, 13 Oct 2026 17:23:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 17 Aug 2026 17:41:03 +0200, Patrice Chotard wrote:
> - remove useless "rc" local variable
>   - optimize schedule() call
> 
>  optimize schedule() call
> 
> 

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] usb: gadget: f_mass_storage: Remove useless rc variable
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/79af010ce624ce8908202e4937081f3e4c9d69a0

--
Mattijs
