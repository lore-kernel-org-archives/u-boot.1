Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD29CC61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 08:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28DF6406C0;
	Thu, 27 Aug 2026 08:25:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30SAFwibO_4C; Thu, 27 Aug 2026 08:25:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787819137;
	bh=BXXBvUi5uSXmKzC+eRl1ZMx+TgXkIH73UVCVak9t7zE=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fjiu9SvmGKyHECB+0jrAkWypV/JYDKQchyJNa6S6uxdJxFPRiRbfq28YqmssJ25vH
	 pmS+gqx7EujxScDe7QD/ZLALfE/45JC4SvyB/t8TVb2M4rYfyxWR3njTGHtQgDxHRQ
	 DvsAQxberajGegVSZ+EDe0p4LN6MM1lnIExywQGiezUG4VEHtUP2/IA6IyXwyRsBbf
	 CQlwlmt3IIJ6xaVNy7NyS6R1xCpgbQIl45djArU+SBn3S7K98+AcUVdc7fLGc60hF8
	 zrc2GEh3ASnV0pycNZ73VJWhspYkZHMafcigYZwxtGZ03CX40KHs/3huY6+AKz5wyZ
	 EfbAqPllKu3Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C689406BE;
	Thu, 27 Aug 2026 08:25:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C89717AA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7FA9406BE
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-bGr38LxCi2 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:25:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=YbFi+/sy
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12D3C405B3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:25:32 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D32D3FE2A
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787819130;
 bh=BXXBvUi5uSXmKzC+eRl1ZMx+TgXkIH73UVCVak9t7zE=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=YbFi+/syLB1EnsKqQ/PRxSpdghHrRop2o8gEVh1TPqfrvOrI9hkY3qtOcVhvliyK+
 o5vIRO5eAfvQyqJrQgts4m/UueVOyGNk8myDxw0SVGizubNrzasiQYJKzzhR/gmS04
 ZxiOQLR8aAlzs6DIrpL/ZziKnaQZ8S2DPQj/P+/jY+TFm9hZnjr31Jf5rMOBttaw68
 vFYBdtICmySE021kCUQHFaPBpGgt6U56eiaFE1i1x6lUwQ2W0YV2Hv5G/Hq/C+b6jk
 DqWSNYX+vKMrpQcYTN1eCRGttJWeROjCkbTH64Yyina7RSuePqwuPTqvCjdibS5u1F
 ekZS+T39aXxVPvw08dcyB4pZLXWIBVqTR6aI3fOxv0vvljAv/eJFlDDVRBFYrMXRps
 XYU3sDIKa6wg3XP3fgctDzDShxmpGBxHRpvKA+ZLB8bnl5yoOuFRb0RJ3Ou2iY+2sR
 F7a6ekk6HjgMCwwoQkVKyCIHvs2+iogRM9JE2YzbYBMw9nqWvVwxwonV9/gVIV1Zne
 +kmGJiMsDzzQB4A2gz1Q4KLEr1K5f0VdL8oQVpWWNFU2umtv0ORQi50nmLfW90Gg0P
 aomcWu966dHmPo4HhtLhvsQDQ6ZwFrZDsGB/xkwhfbjraGz0VhpIvUl3A3VPtVSf84
 FKF6PtIXhgWMGe+CqiO/mMyA=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954a93c565so10697165e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819130; x=1788423930;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BXXBvUi5uSXmKzC+eRl1ZMx+TgXkIH73UVCVak9t7zE=;
 b=kA6vinxrOl3qYrbLzh2zkiTk6c0IfEwCcPiqf+tHLKk9d9H2+WY6WwXID3gGjcoUHn
 0FrgB/AUxWvpfe3O/F2mue3QFxXzTxwYQDV5NzpiqKqVKMMUUTM8GJ53RNwTdcSfh2As
 wO8b40ZRcpP/JO68E6VowX9wQvn2hPqVYH/t0il7fCIBDRsf2hei97B3vXF60DD3rCXW
 sIBkmmhmolCvr3OjgYzPv1/MlPS54/EzWDV+0WCw8Bc95R/8oYKVVlMJ9GCBb7I9SPOa
 drkfGI2K25B2r9V2ha1QKk65UhxEqUkZNr+ttt5C08lLFHb2podyg3NFat7jdV7YT1JX
 DE0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEOHnsNeNm0GpYVJzCcSzNoF2YScaclGsTLTME6WX0VWLXAaiJQYZhW68UjidkWL+R+pcpK70=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nNsKRNMWVfZeZ75kBSdLlT5fPQpu422MvNEtMOJJC4UNMwYzFY
 lPJJ/nakdiW5cHExrzOMBtbk7wxDdsDDiff7UMaP93CGYS5PhNvUF5bYsJTLfQo2okhgrjzvnJM
 RmxwNeQYKNUp1I/EI9DGn8n/hNKvyMfmN+BOvMvfcARDczzxUNlc1tckLu1ApjXhBUqEp4i14AB
 Lhd0rz+SMgVA==
X-Gm-Gg: AR+sD13qn02ywl2exI5brYZosqznlaSMD9g5NO0ZSJpophpKsKTGN+WK/UShWB6YJ/n
 0xiIhWR+VgvpMI8F3AZ5UycwjX9Js1ndfYhLKlzY4G6WvobuxAJzHEuVUdUCbYlD8ElEkfZ0suR
 hehqKAv39qpeAH6gS/ZtNLqHyp9sLxcHnMMdXPcBZP8wuQTcdknfA8dW3Zz/kjJAHYOUjRPUF0Y
 tR4A6lizEqjCGxaQJTzV8b0ZjpqXVgobFWYvkpRLqukGQi5/AlMEowgEhIfbUJIOBxZzXwOjdYW
 46fuXpSZHj0F1gCMzbrWmDlzZtcPokjg/K8lYB4DOAWd1a3USa0T7NYHaObH3FV++ktY9Zyo7q3
 VtYrBZuNukRnEJH/ZmaT4lA/PNe1bUvpArBuxe27kyD4KGKuLGVtpvlOnJ48yGDO/SnZtZy7u21
 0Z9D7LYY8=
X-Received: by 2002:a05:600c:5309:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-499dc702b09mr154393435e9.7.1787819129829; 
 Thu, 27 Aug 2026 01:25:29 -0700 (PDT)
X-Received: by 2002:a05:600c:5309:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-499dc702b09mr154392645e9.7.1787819129425; 
 Thu, 27 Aug 2026 01:25:29 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:d8da:da16:d52e:e57d?
 ([2a02:908:1242:30e0:d8da:da16:d52e:e57d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm35358615e9.1.2026.08.27.01.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:25:28 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <e3e03c35-4a17-4d0e-8bf3-6c3d47857851@gmx.de>
Date: Thu, 27 Aug 2026 10:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
To: Alexey Charkov <alchark@flipper.net>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas
 <javierm@redhat.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
 <cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com>
 <20260825194528.GB523975@bill-the-cat>
 <CAKTNdwGJfC=11vdSzL1wbE5WTF=4S6HS+DYMzJqYEQxD6kThGw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKTNdwGJfC=11vdSzL1wbE5WTF=4S6HS+DYMzJqYEQxD6kThGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/27/26 10:21, Alexey Charkov wrote:
> Hello Heinrich, Tom,
> 
> On Tue, Aug 25, 2026 at 11:45 PM Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Aug 25, 2026 at 09:37:43PM +0200, Heinrich Schuchardt wrote:
>>> On 7/31/26 14:40, Alexey Charkov wrote:
>>>> part_test_mac(), part_print_mac() and part_get_info_mac() each declare a
>>>> single-block buffer sized after the descriptor struct:
>>>>
>>>>      ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
>>>>      ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
>>>>
>>>> Both structs are 512 bytes, but every blk_dread() below them asks for one
>>>> block, which transfers desc->blksz bytes. On a device with 4096-byte
>>>> logical blocks that writes 4096 bytes into a 512-byte on-stack buffer and
>>>> corrupts the stack.
>>>>
>>>> part_test_mac() runs on every block device during partition probing, so on
>>>> sandbox with CONFIG_MAC_PARTITION=y this crashes on any access at all to a
>>>> device with large blocks, for instance:
>>>>
>>>>      host bind 0 disk.img 4096
>>>>      part list host 0
>>>>
>>>> Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_PAD(),
>>>> which is what part_efi.c already does for its own block buffers.
>>>>
>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>>
>>> Modern Apple Computers use GPT partition tables.
>>>
>>> Gemini claims:
>>>
>>> Because APM was functionally obsolete by the time Advanced Format (4Kn)
>>> drives emerged in the 2010s, Apple never updated the specification to
>>> establish official compatibility guidelines for native 4 KiB sectors.
>>>
>>> If Apple has not defined how to treat 4 KiB sectors, we should not try to
>>> invent a scheme.
>>>
>>> Apple has already deleted the documentation of this outdated partition table
>>> format (http://developer.apple.com/techpubs/mac/Devices/Devices-126.html)
>>>
>>> My preference would be to remove this driver completely.
>>
>> Yes, this is another case where we can just drop the driver and if
>> someone *needs* this for something, likely emulated, they can bring it
>> back.
> 
> I've sent a separate patch [1] removing the driver altogether, which
> Heinrich has reviewed already. That one is against next though, and I
> believe these fixes would be great to have in main, so I'd rather keep
> this patch in the series for 2026.10. There will be a "change vs.
> remove" merge conflict when main is merged into next which will need
> to be resolved in favor of the removal. The upside is that tests don't
> keep crashing wherever a Mac partition table is probed for with a 4Kn
> storage device.
> 
> Does that sound fine?

Nobody seems to be using the MAC partition driver with 4 KiB devices.

I would rather drop this patch to make merging next after v2026.10 easier.

Maybe Tom already wants to drop the MAC partition driver in 2026.10.

Best regards

Heinrich

> 
> [1] https://lore.kernel.org/u-boot/20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net/
> 
> Best regards,
> Alexey

