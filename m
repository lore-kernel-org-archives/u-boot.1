Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE3CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E994180D6A;
	Tue, 13 Oct 2026 10:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNioOBryYfTO; Tue, 13 Oct 2026 10:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DCC280D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887101;
	b=m6qC5g7kjG826rARSh26IVsw/WGu8SqwGhv+gsvODd0aX0VA2KjH+3idRI9Vk/H4sP/N
	 +nFhtRDVIGpXjX28Dv7S3wwksLReNwW+5F+a3BkHDJSwbwkIg1qAhwoVa+2LnYi9f7v78
	 6nhObFiykneUQE+Exit58+RbVsCG/Iy5g8WNjAr5vgM5FHOibQ97OGGDOW62ISmV3m9sY
	 vAm7OzQTJGmGP+bynh3rA2dnlcOeIKMRPJs5GeCBVrQSb+j1r5lCyzKtWBL/GkB1R/dvo
	 5H8wu+g1alecTOc0Vd66UmD4EDv6FmcGIw2HdYp5SYhb/FkdRlHvwiD9/N5YuS1dDMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791887101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G5HY2Y0Wf0FmNLxSyMQUIh6Y9ourZXo2/ekoHBGPXUY=;
	b=TJX9ec77KbI5fvxerZ4+lLiez7cONso5xNs3waSqw97hcQrSnS58FDw5s6oXGIJkkCHQ
	 ZypinzX2yNpujqodLky6bpOkIIA1X1jSb6wE2dKebJtzj8ipac/fEXDBhpHGeOh6zTVMJ
	 XAnDhUSc+j8cjf34PAx0lPmrDFOs2b5TlUIZy3UsKvr1dzypcR8hP7VH9dRdJ8SDTTavs
	 nSLzgqn5gRCtZXm7u48oVhyOupvEz1xqVK2aKfLaJ8mhlD5QyOdXjFU1I5Xih1HKrQ5FC
	 g2VzM0FUZzrsiUUhdPOuPw5Ejc/pimcgYXVtmyy8cMRwVGEVoP6GZZKXOVQRH/OJW+A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791887101;
	bh=G5HY2Y0Wf0FmNLxSyMQUIh6Y9ourZXo2/ekoHBGPXUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6s6cTjn26+gLrWHJrQ5l797UA3fnYU2Wpm2SuJun8KAaVJYuMcYbgAkA5tNJtvH7
	 cPJqrV+kZ1eq5w2Jjk1MsgqeMxSxaT/KexysyAoLOfaxU01vXHTUgT4BlcuePz5/Wo
	 x2/o/DU/Y81ZLI1faxPgU38npG0Mwi3XEpU2RrVwJNnrgZtYxcNk3q7Z6x1oExJ+41
	 M4e1nQj5T/bZeMx6Wvc6xtOVNo3wS/1IEDkyDyCBPrYIX/3vki2ceLd3cAPlSQNFwY
	 AtIXTspeckHcyRhciSyhoe2FtbskKADkRLvY5emrQJs2l58ncL2BXE9PGaCmQZvOak
	 fHB4bFZO6+HvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DCC280D6F;
	Tue, 13 Oct 2026 10:25:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F418A75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D959960679
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id in-qSpWf1p2C for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:24:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DAC1A60688
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887098;
 b=k39RAgvCGOVCsMW6roWIVhXrfaxgcDCME4rMaNy0FCH49fH4HbwYUu5Y0b7a5suRuXCD
 rK2SoZ0zBh9YPKjEoy5F4ejDVfjmVoTzYrSUjotmwTCXxll9D7dUkItP+dWBR/HXnsdU3
 9EQwQxTMyb+5V060Zcu4SuY5YhVQCRrgANtFK+6jh/VgAvg8UCMEnk4KCtYSYYR/z7d+c
 UP+aLQGqo2BPTUsvE9fjfFkFNOWDHKXcX4KlXeJLpbLiqa6wvsYHM5gtESY3u0kISquFo
 /q5gQkT5UonHKRJSUd23A9CTkBtyVIa6oUDEMWkFXzQEItxUuCkf47WSQFPc3HSaWMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791887098;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=G5HY2Y0Wf0FmNLxSyMQUIh6Y9ourZXo2/ekoHBGPXUY=;
 b=bNrlyAG7wJQ5Wvawf8EwNqlrQ1PIgeYMlY4c/k9bZ8FUQJ04bflCFbjF132WsX7X5zgj
 758Al8zecMOwy90z+erPolMoOy4R8GiR8FsnIkU/7p571Ee2HxPV9SKbydumQjfUS/8mn
 kjB4eDEmUGDNehKH68iRxiYbkA5mhg36cgFI8IJbANSz83+GrjggKHdOyCzn/sTiKjM6s
 P/2RbsJslHsoyFmlCkvQ469PuuJQj0nnjAT8zXy8mnx7iQm581OCPYdtchN4f7wg7Lf/W
 b/DthtYiu3tI8rAIQMUV6c2r+d00utr0iiCMKtFRxzw6r42zrJmkmNY189Xu3wJPaZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m35sccSf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m35sccSf
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAC1A60688
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:24:57 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso2901971a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791887095; cv=none;
 d=google.com; s=arc-20260327;
 b=KgRB+MurukaPltujnUuJVkLeewc0sPQeqFLh4URJb4iSay+5KTUTMpon8KV0eprpfz
 mXZbH7ejFwzhtI/T6GpXrPSRdQMqI3eJLyLgWXjPd0dgNCdKsvTrw6uNuGAFQd2+Zgqn
 WaYEw53kB8BIgKTqcV/cG3tpfI9Hl1EQAiKN8RxAKfbii6hpVsKRU+uhMQU4i/mye2BO
 hEpx8no8ct4EE1rLOiNdJpU+MPuzfggnQe6500M7G+iVrHKxSInDFD3ibG1Lz9Ix5wkU
 MvqtNxLXURJllrxUxQve4VLHw5sp84sgjj7R+S1rtrWnHR89PHuAYeQ/cnTp2ktIp2HT
 pGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G5HY2Y0Wf0FmNLxSyMQUIh6Y9ourZXo2/ekoHBGPXUY=;
 fh=HNvyiKdY0EVXoOVdehOWSAhbBVIvKB9921VBkS5FvAg=;
 b=DlOidzz6RliLECz7rYwSY8+t8BSgYpr8rbmRfFJYVb+DWOKsYjONw6WfYY57jQVz4H
 sNWtm29YxQxa2h1GBXQ/yYaGsNWqRDE6bFJ9Br9rbyCXv88pJhSxy1SdFRBh0tyERQ6f
 jVX1uIwFN36rzZwfZdJp+2cEqqYKpUDjPrVJIIq/JkJYEwcsDJAW75Wc3biI2AqvU0a0
 EKKQ0EoMqf1ageDgItZW1iWRIr6ooqVitqOE/OHncdyiNkl65PWhqSFyGkkpyArAFW8E
 XsWXXCD4kOTszbwlnBF8LfQqhZY7vV8/Ftbl1X9BIquBbdjuJhA0pM846KK64ctVz+4k
 86yQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791887095; x=1792491895;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G5HY2Y0Wf0FmNLxSyMQUIh6Y9ourZXo2/ekoHBGPXUY=;
 b=m35sccSfPJAIZvlCtIfwFhtDdYWVqEMDg8vYCT756qBsI5g/jDzM3vmMpwpWN46G9n
 E0VcsA9UJPveEWrSynpjvuQyB31bgRA30kjK1QKeaoxjPuMQ/Ef9gbByvi2t3a49j5T/
 X0qhy+41VCnWK6kixp41C6Q2W+ueXPKIaBXJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887095; x=1792491895;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G5HY2Y0Wf0FmNLxSyMQUIh6Y9ourZXo2/ekoHBGPXUY=;
 b=FiiIrWP7rKVmUozROtJSN+F2cNculzJ0O/D/WFeephzxoVl8Dnkd4xl5arvPTlZIfC
 oWlOb0zxxlu/0DSCy1sIj5Tl9AzK+CaF86O8W/B9rvFpgXE4m2b3n4UYts2WdxfK7h/Q
 WdXK9wsnU6Sveeg8rZVHAjyACwuOSPcwKetuWjuidcHXtLloBN32+aKYxVhaZN5E12JO
 Vvr6T7Hut3kgDlhHjjlEw8xEvYyiLaPQdkerY/oPqqRfdvDsXtMZ6xdLXCV1aCvtYRsR
 Uev09u+t/QM9i3zhhFve2BzB1kKpuEjv4uuoAGa10C520pSsO9qPXv7y3ywVgXuFWfjc
 Jabw==
X-Gm-Message-State: AFq9FYJ/vLKE+RS1rH5cJCeXuQsSg4bPOavPx0fCaWdwkpChI1YNkPPZ
 5vBrEf4iZ+KsG5FcJhrY7sQwwPJYoE9bC1sLHikrtrKzYonu+rrS0aWGTT/J8rfFnjwfFgdIA7z
 piwYz5Rit8ZYSH4hmKyms441yWbWnmjsq1KjrMS+u
X-Gm-Gg: AYBFou1rL2zLnac45WfEflfwmLZiZayy1gfmPOkNljwWTlbQViOQMkpWgFl2P2U78gu
 aTgBukNx9kBnetX8/TuPazLiwn6XLYffK56ERlo/YHF4RP8O0UJ65P4k9ypNS3+RSA3RdfyNmmC
 G0cPLTWOTBXnd7wZLO4RhhjiBl8fbVLiJ639fk6LqlZMNDd0GzjmiklEKbz1AQXHVGd9tcm9qGo
 CskFO59e4OKI+vAju7YKhc5+mxZbgkwVmOumodUrGyciITfomNTOpRyfvV0M/bBwUq+dfErRCgP
 ZIU+lauRSErRGwlcRq0OFK7Ns0BYszsMRb2caDuYmUWX+Qp4YCS0gjQnPA==
X-Received: by 2002:a05:6402:50cd:b0:6af:7d49:728e with SMTP id
 4fb4d7f45d1cf-6b17c24437amr10140173a12.16.1791887095437; Tue, 13 Oct 2026
 03:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-4-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-4-f8e593f024ab@oss.tenstorrent.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 11:24:37 +0100
X-Gm-Features: AclHuK_aM5b2_MhKNzgBuTmDKC-5aOGNBTImxxz0OsYwa-PJS5sgkweSg5voGto
Message-ID: <CAFLszTgd4KOkdnUoUxvTQaUOr-fnuggfwhHa=bvBzdqsPH0Juw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] bios_emulator: support 16-bit reads on VGA port
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-03T20:07:54, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: support 16-bit reads on VGA port
>
> BE_inw currently doesn't handle 16-bit reads on VGA ports and falls back
> to LOG_inpw, which doesn't do anything on non x86 architectures that
> don't support I/O ports. Implement this 16-bit read as two 8-bit reads
> (similar to how BE_outw implements 16-bit writes).
>
> The Aspeed AST2600's VBIOS has these 16-bit read instructions in it, so
> this is needed to emulate that.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/besys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
