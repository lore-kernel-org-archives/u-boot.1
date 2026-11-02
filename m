Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038D606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Km9aAi9L;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jUxf+iwG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C532D4053E;
	Mon,  2 Nov 2026 23:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cuhp4h3qtW3T; Mon,  2 Nov 2026 23:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23B59404DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793661949;
	b=CtNMXcMOMlWg6/WU1GDUxAxlz1oRLocaZOjdn8TZXt1mqYvQb0gsjaoMO52oeyvFU6UL
	 Rss4V7jY5kOLdfgmAklI6LBqNQ8NNBegQpBl1uInVWk7LAM13l2ePLwou9Q4VdEhG1EbS
	 dXW6dltikeysvMeCobO6bwI817/Q5NzuujFu653WxoOA9UIs8Sg66+bQMmB9PabsX6GE5
	 Df4SjffilsSoLOQjw0Ea9JDnm7yrGYZ1IMx8la98Vksb+vD041K3A5Bt+uDLvYtvk8fkx
	 D0eo/P8si8kulO1YCiWid9zNZG8kZDxdrBbAITcnC2aiYYH86LRFhWiDVUwMk9PLTVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793661949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2LVFZPf1yort+veTTnY/qsIUXHaEGP2afdrXjKWSkOc=;
	b=sKljkthzy4mzXs63brejpKlAsuZR47rVI2lOIgeM+Rj1XrKXlvGBl2VBol53g/5Sud2f
	 vBjLmvZi8U0OkGKZTvaZl7vJLtDhPaSIyuBARSLvirnWRdKIT8InEhK3D+06u7Qt5SFG+
	 IRIKNMW7rMxOyjdK4yMC+sCR7faLSagVk5HeXrY7q2xw5xIaolmWCOD/eU5f25vTci1vJ
	 rWZ3OOm/aBuUR9Y48oxGO9qIttiOrYwndYMUAmqmswEtI6ezQ3qniZCS6slBBC552VprL
	 Kt+le+f2GF8wjkwi7gggd3o91BQqQcTyFe6zT6nfZ7+gSr2DjGLxwJJvNjWPVCMaAvA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793661949;
	bh=2LVFZPf1yort+veTTnY/qsIUXHaEGP2afdrXjKWSkOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Km9aAi9LF78+5JQzWZJ/u8v1wGIn3FCSIDiZivX/OqWJO0j9q0bBK/ZmbNcOjAuJN
	 3V4RfmYeBI+TSJtt25jQrymiuY7Oq0fP53o1HT1lpE9GKjDeLcHrDlftrSa69SWl/e
	 Mvk4CIyy7IivTrVU/DRsBIOuf2DW2SSG7tLa/Sp8Mq+vTheZa8j2TcKNlI2+5OECU5
	 uCxd+71vS+Dgc+xQ9DTNGeBfCOjIHxaJVJrbvJQ9VulpIXKIQqNF6oa1vHHRhYzoUi
	 NGa0MmchVUkPg/JCfeCrFHBJDzUHgUGdEX0VDDuY+ykDJTgk6Drt36EnTMHZCzr9SO
	 LwUBhUWrwMTpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23B59404DE;
	Mon,  2 Nov 2026 23:25:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D50D72AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 23:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAC2F401DF
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 23:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDLWLE-Aak-M for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 23:25:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9B5A4400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793661946;
 b=J7iHAlzxKdzko6KU2cXPbZSo35RCweylGdAqsNJxv1dtDN5AcaS32Y8fiSwRt2HNzR/f
 BcpHRK5IfAy1Pfml7ABs3MSHh5ssLTE2DupWwGwRbecvoY4HO6JZD6SKWh8AFZO+XOZg4
 IFyhpAQ+Lpu5nrJ9n+Njkx4RlamWba2yPVsdlw/KKm3Zb+58jmtlwIMn7In/RwxZUs10B
 SZX25UeMICu2a8/TzNIYDglKzWE/AKb+C5RTZxXiQulMukXpFOOnO6wklp8Pkyyo1cFVK
 RlUQ7vmLlHwZy1BZ8U0UavCTqEVMb2YESKWQSVqRmJtqr5H3TN3DW5IfdWc0qPgds4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793661946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=2LVFZPf1yort+veTTnY/qsIUXHaEGP2afdrXjKWSkOc=;
 b=UXgfQJiAzdsojbbUiTGvqtT/OzfJjk0I6bkhRufXiT7GdhMsyOigt8j8jKzGjc3P3j7+
 vXDYmmnq78FvMz8xJi+zIR1/f2knD6IgHiWfgTK+tIvncxJkHhLg1T2XC4ExcY0nSBS8U
 M4Bj2XpeRH7OLlhP6gXVRMDFPSBjrjPnZ5dJSIZujvOQf5/td46tuf4xpe9KXKzBq8QHB
 poVxfa8VrA0R9Mhz8anPzzBjMdPcCliv/ZMZCH6PHTumiAEYgVjhtux6UAZFOGu1dwswW
 iJhoB/TopCO4Go+zTQBLpfYBODiWXZu+vyQ6oBXVrzzoFKp9p3X/qtGPU99WUqXpzNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jUxf+iwG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jUxf+iwG
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B5A4400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 23:25:45 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6faddda49e7so2955770eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 15:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793661944; x=1794266744;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2LVFZPf1yort+veTTnY/qsIUXHaEGP2afdrXjKWSkOc=;
 b=jUxf+iwG32oAVupbFAa6tf/x6cBsL9SYFz9l9KU5aV0mHJ8rWeddkrl6IeJb8njNFd
 5ew8RJuC7naFK4QF4KUvsP6pxQlPk2/ieFEBUY2wYaM5KRRLxegxKJnJX3FyjbHUtV/B
 V4Xts4TP+xMPaaL+T5SPNo3VLpI6Sy246onfY7woBSSsm2bjG1/tc9HJAtz9m1EjtTrj
 pqom1c1DF+3EYDjgzHvlEG532wteEwUEqK10R4n/ZAG+QGIIrFJ+4oBth3AlQfu+VlLg
 M11yyudrg+p5+wUy57esOdIjh2ciyr3XP2cdL6IhY3HRr9gF/qUJv9pkKZIB/Yvlimim
 1mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793661944; x=1794266744;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LVFZPf1yort+veTTnY/qsIUXHaEGP2afdrXjKWSkOc=;
 b=Vauom4Tuwg62m223z3kaz0oxksr9DAfM0GOqjRJE9+72NWz1+UqQcZOG//L3y+o3h3
 4zV1F6bTqWgi43+rf6kAN7XF3qgLKxEs0w41eDFy5SIv92nRhiGequ+hYzXSEoJkLCss
 gzjff2fd5S3kmO0xHyvgesMTaZV4QbMtwqIaaLOX5l+YrZHaKvr2KTkOy3c3C6IU2hMd
 eyV2vGpBlx25EwttH9n45lTco/kFel1WTkshatAPHAPD8C3T+usTD4jQuAaKdU5cV64i
 vq8hNRegeH7uEqcGQ/VIIPNCcFcKpXecS47cx5nxy3oPk7aBbpYhTbJuS8J1mtro4Qg5
 /iVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByCDnuagVIOPOZhq+n6/EC0RYS3K3S1w/w1abFqMjne+rGp8Heonexn5ivyUGJ58oReX18WtB0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRogzzgJ/TNIos79arQdqm6qIiQOOmJwG15FnPMEdGvWMYXuZz
 IzcAcHoOsfwEgSGzl6aqshJzZHeNCGYuJmdIoP7/3EKnJs+921Ane/NMiWnc+oTlIBk=
X-Gm-Gg: AYBFou0v2lQYFzrAtkKIq2BPcDI/g5EsP6kVU3tApg1UB0zQ8LjQK0cWhCnahZc+O+3
 DdxBkLklpfLz5/VElBpvDpN9umsPQw7osD622SE9jij6H/P/JYKozl1hHIvzcKtiUNt4Qze1tv4
 KRfJeT8JGQikwqWG9uYaOx1RJ0z1qM8HwOeF5RbOimPRnzXoIJQTzgikVNlhW+3prc9MGGsdOjL
 7OteOdtaVYPDKszl3qkq0kLhYI1+E0hwteDwIKw8kDOC2lE5Uz9Qw0aJPdg9pdMNMyaWq6vzsZi
 JKcyUFMvrZvbGfc081OTWj1JpUGk1beKazoEov+wQsN6MgZY06mBw5I7znsS526IummRmbuDkMg
 WowNIfhWnHJfnyHaattRp5lU6vIr3Zzxsp9+fVbfDjY6rDco/yadUbpKnDqj2cVwguGQvOjl+zZ
 Wpdfb+NxNeZhb7mkkJKMwon5Zuxpf/sJ3l3uGgDFIkFSucISujUR3qHP0lzzcjjeulo3KWH+U2c
 k67fw4a5l9H5WUOaEuorEg37zS1XFM3n5BC6F1nb72J05/PsmQ/TYyb5NcAo2Z0E/5rdlLD6uou
 djZWl+hwW9cGM5lBX6LwX61z3I9lAOPz0Xn5i08/7SjzGRiAIUSovODxmSmuGfW4kJLHlFX8Q5K
 4fa52W5kBHbuXPhzj74z27wU=
X-Received: by 2002:a05:6820:341a:10b0:703:8835:5fcd with SMTP id
 006d021491bc7-714f2421878mr4383571eaf.1.1793661944017; 
 Mon, 02 Nov 2026 15:25:44 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f?
 ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f30600f0sm9907927eaf.12.2026.11.02.15.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 15:25:42 -0800 (PST)
Message-ID: <f689e652-604e-4acd-b922-96bd0cead8b0@baylibre.com>
Date: Mon, 2 Nov 2026 17:25:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: mt8189: enable bloblist support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261023-mtk-mt8189-tfa-fdt-v1-2-f86616860bcb@baylibre.com>
 <CAFLszThpZaQySrzTVH70dTuuRZqsOp-kFN_AX+01L+KuS1npwA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFLszThpZaQySrzTVH70dTuuRZqsOp-kFN_AX+01L+KuS1npwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 11:34 AM, Simon Glass wrote:
> Hi David,
> 
> On 2026-10-23T22:32:44, David Lechner <dlechner@baylibre.com> wrote:
>> configs: mt8189: enable bloblist support
>>
>> Enable bloblist support so that U-Boot may pick up a Firmware Handoff
>> transfer list from TF-A and apply the devicetree overlays in it.
>>
>> TF-A BL2 can describe the DRAM with such an overlay: its size and the
>> regions reserved for the DRAM controller, which depend on the DRAM
>> fitted to the board and so cannot be described by the devicetree built
>> into U-Boot. Without a transfer list, U-Boot uses its devicetree as
>> before.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Reviewed-by: Carlo Caione <ccaione@baylibre.com>
>>
>>  configs/mt8189.config | 1 +
>>  1 file changed, 1 insertion(+)
> 
>> diff --git a/configs/mt8189.config b/configs/mt8189.config
>> @@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
>>  # CONFIG_BOARD_INIT is not set
>> +CONFIG_BLOBLIST=y
> 
> Just to check, since the DRAM size now comes from TF-A: the MMU map in
> armv8-mem-map.c still uses the fixed
> CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000 (8 GiB) a few lines up. With
> more DRAM than that, U-Boot does not map the extra memory even though
> the memory node reports it; with less, it maps memory that is not
> there. Is 8 GiB the largest DRAM fitted to MT8189 boards? If not, it

It is the largest, but still could be nice to make the change anyway so that
we don't map more than what actually exists for boards with less memory.

> would be worth sizing the map from gd->ram_size, perhaps as a
> follow-up.

Agree, as follow up would be best.

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

