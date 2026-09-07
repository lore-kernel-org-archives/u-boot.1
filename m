Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65629C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29A5180BF0;
	Mon,  7 Sep 2026 08:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AF-sqnBSN5D; Mon,  7 Sep 2026 08:53:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6EA5880A8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788771199;
	b=LaZOH/3ETVlnZasH+NoY7NWJwX9rE9HLy/Pfs657gGf8JeFAfM70rl1Zm7L07JQOuiC4
	 taAdNyjEZAHMM6t1eB3eZjrrm62dnfMIM3MDplGCO80mYrSnVqNASI3CGasDHE0F+ncN4
	 8kuN+t8LFYG7OcUW1Dj8r2p66WGTN8ptPOd9X6af7/XZ51cmu3BVh1hkXiC0lfMeFowf6
	 +G8UkNEln/CKacA23bkPPz+UI8Kb/Sk47EYnIzNeUQLIdSnrWSZrDSq2uf8XA9//IIc0O
	 R14H8zpX/1qk57vpm9W+I+Ehv+dZb1Fry/xylfOP8mq24O41cS7ewUW9yjqr6hUTeuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788771199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2j9Te+mEUhw5flvASS/efM9dOksCoLxJZTC32+ABMBk=;
	b=bPpjaJbo+5fuFSSvGmXn+SzBYWZ6EDqh40jp2iCQOyQq9tFPumxx2kQjeJToPRpcD2LW
	 eyg5OIbfWzh151IA/veXK2TN8qQKk2Ucc4hg3EObo8l+7R4DEx+4FEZMVUfm/lbJw3wQg
	 svC/rd+H/s3COUX1nZeZ398KAm59xVhoc0hor42+J75URRfYWXnbGp7vfqJchIP3yta2F
	 0TdO3fTM4LKEBoX8VxyaUfixIlytABZVi+2P5B7ZrJ36kan0Qp2D8V56Xb7T9DrGJf/aq
	 +4VsZhe5T67239+Ozt9Hq8HGgjMZf0QT3Ytf0kz/0H9hfbIPGX27ita4HoOO9daUj1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788771199;
	bh=2j9Te+mEUhw5flvASS/efM9dOksCoLxJZTC32+ABMBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=atGrjRYD2MG9iUlsJXk07J7w7DiCxC8hK7dHrR5DnzCYs7NFwT0ypnSl7pnb3/C0U
	 Q/0jjy31h7uxSSs8AStjc3gl4vpzFDIvcjZqKr4i7hnl1lcp6GzqQXsefRls9Frkos
	 ShpnZQubw3YrmrufL2vN44H0BZoMu259pTs8YYcvDQkeEubG9Fja5Zil8lUVheExsG
	 9VzePVluuOBMYkvqiqjovV/7nZuVtSuUChX71ZQD606daxE7l0MnsanDCDwupPpZ16
	 y+0vQ2hQccPOE9Zk6HC3jUA2uJqIrmNQXglaqCpiny/Xqf4+IAgrJoFMTPOyIshj6O
	 tP7IkHlt5CT+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EA5880A8C;
	Mon,  7 Sep 2026 08:53:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5333C9CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 395164009D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4cVSjrkPkXE4 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8A50840068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788771197;
 b=GhFJlAEYCw1LuRHm5xQUTipLrI93JxnoUfySpa/vGjtEbPk6lEYMkNvGVRlpqi4P1tgZ
 ruGLabp4qudK9xT2S/oHzJo4pt/elyd8qv/z39tkODKOFimBV/VCAn5GLXUA/9yyVovbT
 UVIt47zUq6jdExN7sqNGrnA2j25vkp4Uas8+CaCakBxGbVqR6v3O2qgmhTcuVUy2sHtPT
 H6bjb6DXtqmEP18X90OqzLV3NMLWnBzjxcLnJvpqZNF8n/ZcT5wHX4tCvWT+SCeOX1Il1
 Q/Wu92KUfX5LRd3G1DV3OK8fI1YcmA7MM9xsCCWSIXtfsLAgJi/+nB1VSJ008ZMduQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788771197;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=2j9Te+mEUhw5flvASS/efM9dOksCoLxJZTC32+ABMBk=;
 b=TqASO7yFtRjmE3sfWJuRHW/ZgEm1GISqtjOoYmocA4JfjjFsm8SuZeEC7lpdUMF3JyJO
 rs2UbwwEfDwlsLTXXXR756goKbrQ+baSlQkYmhqNOpn9DemmGhLRKNoVOgvqpwOY3bGfA
 clz73A31Cwpobj69BhZwWjBdsDtvYh95XlZ6gTfnxYX5Eit7KQM7mRbIWFkXNfjRcTW5T
 L6FEUx2IGYRnY9JRN2M8GxlSa06hDvwEAxyi7Q8C28D1rlIxrDb96kWnvo9Tllt83nRNx
 k8cSuoZuR/cW3pJJ0xRHDTByj5fOo7c4+5vtQYHnYd9sy060YO2TP6u0rdBbTJ8vkpg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A4cOTVVW; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A4cOTVVW
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A50840068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:53:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AD8E60052;
 Mon,  7 Sep 2026 08:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241961F00A3A;
 Mon,  7 Sep 2026 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788771195;
 bh=2j9Te+mEUhw5flvASS/efM9dOksCoLxJZTC32+ABMBk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=A4cOTVVWJDzCp910qhDChG+1nleuZj6Dq9WtMz8dpY3l7TeuDd7Gjzuxmv9U8Ug9d
 cJ1uTo3s6HGGShgmoFizp+Kvxg50DkxnOpFZKBQ8zB0MfDJ9Kzh/JyFktUlw1Mzh20
 S9oVOPynZ1YvHGTbRVpJOE+hYcuVVkET0Vha2pgOiF4qBSAMKIJRQri+svRjt00wuS
 eUvz2b9GD2UTFXaXeSYIGDX84/2W5K4nZTiQq04BwNIQkSIF+d/ToWO6bd8p8pBaqM
 VNPvCKTD18keK3Q5JSpNmriZX6Y7KgVhetjiOdi2in5t5RZece2qQclyl7Cgdfia4n
 G5NdfO7TLfZRg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 1/2] usb: gadget: f_mass_storage: Remove useless rc
 variable
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
 <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
Date: Mon, 07 Sep 2026 10:53:12 +0200
Message-ID: <87ik4htpc7.fsf@kernel.org>
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

Hi Patrice,

Thank you for the patch.

On Mon, Aug 17, 2026 at 17:41, Patrice Chotard <patrice.chotard@foss.st.com> wrote:

> rc variable is used as sleep_thread() return value.
> It's initialized to 0 and never updated inside sleep_thread(),
> remove it and return 0.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

