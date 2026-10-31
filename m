Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69909606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0uR4HVxP;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YAS7CN4J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32F6A4059C;
	Sat, 31 Oct 2026 09:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeYM384uCx7E; Sat, 31 Oct 2026 09:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A127407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438979;
	b=KVhgaa89JEKD62o/JkcfrGlxjgy9i+wPn24Gio5NyWJc+moU1gR18CJfIaP90ShcJ2IO
	 GKQ+d7GLAoEHVxzRNOD5+zqUi41JQbGuIz+LLtWm8R7aYmj5oAu9TNnSHtXbaG6GaLLRI
	 CeqZsa2si2dAchGHTeRgW5WErevMJTv49pC/fwMHrPShaKab/p10a3YqK9xbiK7RmKI+9
	 3yORtEC2JMD3qQcc1OfTvwyVAhOYTwpXiQput9r7m0yPkrYkihESsX/g/eIeQ6BkE8eSC
	 dGOxn3B8mV4TnHhSQxEX+qG1yJitTRv7PIpWhCgdOhbz4DWyVsFUe5A2td4nrkth8EA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793438979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Lvc14PjUnHwiDm6R6tqNVgyRyaZbBeBK7nOH+UZfLes=;
	b=RGapOVuE4yiJcJqVTelpgDfohHh3U6aR/KTVTIvKH9mBD1jjgoD90Z8zazlomUaiinHg
	 1Hz/R8S1OdaUiP5snRvpIhYQLgik69D9QSkgWGO9d9KsNanoi0sq2YoKzI59Cob2KquIq
	 RZaemeUJBytyrGJoJcCtZKjVMfzvgVK/KqFKy8/5Q3ns/nIcKq0VDvZUzhI9HVfFnbzln
	 6VLbIN1BAAQsjV1ZKztEqowirx3BW8VH4CO/wD2QYWJQdgCyAfOLIyPsgAFBUFegk2+zg
	 kWYoaSccUD3iVJlYnO66TeT73Y4iZEYPjVrVrcJVKfGqCX8PwIUp1uCqg4IZ/Kmzl8Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793438979;
	bh=Lvc14PjUnHwiDm6R6tqNVgyRyaZbBeBK7nOH+UZfLes=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0uR4HVxPhqOvmg6NEBbzv4EwAOMvm14U2KqlSdqr0mgvTWvUbQrScxzDOVZnuWblY
	 VQwk4fduqhAd4WfHRUWAg69JexEUExUgcpCyIrA2gdJ/CpVnirhesmzCvM/AnbCYsF
	 ZXX/ODstMbH9LfOc+SC26TLaTayXgP48uk02zSzlOrV3GgUSe9idKhrShWWHR06wc4
	 Ee3z/G3bjbqbV7jBYDUUepqSwgzGgIfXjWP0W4b2zhEiSXlDJVrvKcKMF3lNGqxKrz
	 spQOpCXBJh33WPaA9NsZ5RWpAfQAQ1bbqaqb8l+40hrIpSYap2nY3PRfIMGz/Y9QcP
	 AdPMXhtPKoqaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A127407A3;
	Sat, 31 Oct 2026 09:29:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FEAE4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3133E40100
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYAp0Dg6ojBm for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:29:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 48CE440057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438977;
 b=Nqpb/aeP9rZjwjn33bFM5sJbgoDjNG8ywVa10448JFW1Iq2BEMvhRURu2Ib48d/8SV3K
 yBfZ6YgtUb318BI1jr8KWewl3agXZrd8FcCZziLWZ6isGXz98AUvrAS+qY81V9rXddiPw
 KgmClkG4AGyDGqtPOoGYpiwphXt/B5YSaymdHkH60v/1iJAm/Cp5lyhnqkiTjuvk2H8Lp
 kiAUoa20vOuLYkbYX2T2gmbQ2mFxs2qysZocZp9nBx3AHs2rtXZm8sXDEpgQHy1ECRkl5
 VWETn6vMYm1Xei/j9lfJ6RW5fynt0gsFsdOyY2Enm5N59rpRbJ5enizKDJAmmnWG7yQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793438977;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Lvc14PjUnHwiDm6R6tqNVgyRyaZbBeBK7nOH+UZfLes=;
 b=qgVBWZ4sAwzo9mFKqacpDN50ubZdb7teaHeq7FG3mXNYZuq+qSD135MnCjcaOtwFRbkh
 GCOZB60v3sx+85pyhQS0VKub3hXzzFUWa6C3UnV+0UnIR2wbMET4DOpMywKFPl9J0XuSR
 gXkz4W98kq4r2N7sOeKDZQbCo0hil1+ytnRnxxMf7wwJY9Huy/LaKLooKeB2VDFJKYJBw
 9TT5cXuQRt/j72c01kmfvGrGEx9bKaFtuqyydxih7/qepsei/VfNmuS9MDbs9bbYNCnHZ
 dbZ/DvosIrZypcG+4ZA9ckVMvQO+KPBH0ByknqhFGAwxy3gzw8kOy21I0Isx/UIe7tA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YAS7CN4J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=YAS7CN4J
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48CE440057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:29:37 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1ec41d8e9so1604846a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438975; cv=none;
 d=google.com; s=arc-20260327;
 b=RUojd7zsGL0KV3KHpIbr0KRlQ0HJbMrfsy0sICaWa03SGqDbox5seGjEuk3wh0JQLJ
 AUzZrtdsu3jnRwc6dxBevkrPVSbCAruasUxIAtHsjhRCRMaRxr0udahjYV6igy6Mv9e3
 +wVXLwxnOn4oKQUtfBSO0EiYAEJG1dXR7HhoGYabE9AxSXk3KVC6epxbygB47jhoOTJA
 gUNw4ALmj510jnY55Ww06WFfdG78xSmdUWfkDN4yTEyA7KKgFttoccUhqTyPK84/qDbI
 sLLQxxYQVlPdLXPLNMSFldE9Ty1kXAWtv+R/wEcZl0kY7HFVswJa+M5gM+VeVZcaTtnz
 Q3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Lvc14PjUnHwiDm6R6tqNVgyRyaZbBeBK7nOH+UZfLes=;
 fh=eSGTpZ/+rqpDSLRAETcqVHJrTBA7Fx3Zl7gWkQXUacs=;
 b=AVRT90/OIIPwOXZoNxAv3dzgaOFoRKcIcgzi57Q0FAMF3JSGX2CjXGbtEk6Hm6gR4H
 7ids1c+hrLkThD1nCvTf+kjBDx2MZkeN0nhPqLS5mV/w1YKPpNkVFj77MYNGSy2E+Re+
 sltgd1U7suJkYIgGf73slty/6+5JCO9hAGaFCTzPTrsneIFZnmFxHTZxCSMMajli6STV
 A0Jv+JW+fH7sNlocm0rI59naypfielGs9PB5X+4jgw59TamgHGKelBZu1Mh6g75ueNbQ
 +oV+QfStqJPqC+p/nYNZYkfiPe+L6pzkxGG5sKozDwvhIzwC6/ia7KxHNVv+SbJYq9ty
 /SzQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793438975; x=1794043775;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lvc14PjUnHwiDm6R6tqNVgyRyaZbBeBK7nOH+UZfLes=;
 b=YAS7CN4Juh1Me1hCinwyKLK4PlLibWxz7g+hnm+BBfpLqhUkBquIDG7iMG+v9lN1Sb
 Y9pt2UOv3qaHvGnHGbq668TISYPcb7T+5G5WCQdrA5EcecQGoIELBzjwHjHCshR+v/vy
 saQjlt1nPF1wbjJCjE1NtsnJYp91geR6hvHMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793438975; x=1794043775;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lvc14PjUnHwiDm6R6tqNVgyRyaZbBeBK7nOH+UZfLes=;
 b=yaa+okt2TLfNIB0s0lgCjRK3U84ZZLJbHOpMMuOVpdnEPOggPfzZZ2FOit6CxAT6k9
 0CcNGvpkyMVuKFDBJsdUBc2hS/5djEzqjgFQZA0Oda7kdb55kkxwN1dQcuC/g++s3uCf
 tMW263GyBXeosHIuP1uxuekeKZR+qrLUT5kUhFQuZYECybRWFTmvYGHVFtpSxP5J3twI
 GYfnovF8vWU31DzFp92zziC3skbn0u5+rR7lk8v+0XpG6QfuI9/lB5hpxxFVcKW3XzUK
 UkZmtsGG5FsYeMcadvtDOokgNdb2yjMUZvwsjoy8ZEVa9lhZ9hWYutTJ9Z8qWJvmsa+b
 mXtA==
X-Gm-Message-State: AFq9FYKGiLP+iNzGDWDy1BTBftFC+xTIRepdYCNqOhQHr4JGH1PzCNbN
 GYk7XbrpqvVaYtugBqHnLf3KoTXetwaAUcyZa9qhF0B89eK1HQU6Idjez2URlUYPD9gsD6TM//0
 FRu7bL9fKz54MkPNmj596cQVaVCT0lXcvJte6fKYn
X-Gm-Gg: AYBFou3GQkA5oHtdbCYGDzXnO5g70/BvPaBAEyDLopYfMwLYfWpz3l+66CjtAR2BEmQ
 HllQ64jcv91FB7wlerhCjjT03saeEUgrfGZJXGihmNQR/om+g9/F9umWb2zi0vckRzhcp2bkZWx
 IjtzCEeVJwuix1YGC3dpY2QPKP88Bw9cmox4MEqcxxqs5RkddKI9gYkQRTvlbN8InM8B1RWT75c
 xGyy0l51bWQbcQ+YIWGc2IQWUY46FpC3x5GFz26wZX+7Q20cgtojejxlvdWTVBNKxFPXraXBFbR
 f3+yrKZYaVIgfWO9lHkaRKJCJkCtnMjOztTVTMYpEz8g0ftU/eiFHYnDpX9gMIkMT5qqlvYy4jv
 jspcw018FMj58e4aqpmcZKf/eR1+ZjwMlSxRqOrcBEZiC/CV36fmOJMUmpzXOMjqbOXpPxuc=
X-Received: by 2002:a05:6402:1ed6:b0:6b4:d7fb:affd with SMTP id
 4fb4d7f45d1cf-6b4d7fbb590mr3027322a12.12.1793438975164; Sat, 31 Oct 2026
 02:29:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:33 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:01:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-2-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
 <20261020-b4-reset-edl-rebootmode-v2-2-f690da515804@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:29:33 -0700
X-Gm-Features: AclHuK_CVdUTb71y0ZeGAlBQ5BKN1yvCntrjoxVd6r1fbUPHHBFQygzPWFq-GVM
Message-ID: <CAFLszTgwTm_kWrH1g3wtiXtYg9z4+-w7EWGDDz60YvT0O6G10g@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] reboot-mode: add trigger op and request helper
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:46:19, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> reboot-mode: add trigger op and request helper
>
> The reboot-mode framework so far only reads a value from a backing store
> on boot (get/set) and maps it to an environment variable. Triggering a
> reset into a specific mode on demand - e.g. rebooting a Qualcomm SoC into
> EDL via a PSCI SYSTEM_RESET2 vendor reset - needs a different approach.
>
> Add a trigger() op to struct reboot_mode_ops. It takes the decoded magic
> cells for a mode and resets the system immediately; on success it does
> not return, so a driver that fails to reset must return a negative
> value. Backing-store drivers (nvmem, gpio, rtc) leave it NULL and are
> unaffected.
>
> Add two uclass helpers built on top of it:
>
>   - reboot_mode_find(name) looks up a triggerable mode by name across
>     all UCLASS_REBOOT_MODE devices. If two devices declare the same
>     name, the first one found wins.
>
>   - reboot_mode_request(name) finds the mode and resets into it.
>     Returns -ENOENT if no triggerable mode matches, and -EIO if the
>     driver returned 0 without resetting.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
>  drivers/reboot-mode/reboot-mode-uclass.c | 48 ++++++++++++++++++++++++++++++++
>  include/reboot-mode/reboot-mode.h        | 46 ++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
