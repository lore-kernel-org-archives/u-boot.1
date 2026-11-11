Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80B606A32E
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bqjtR9LR;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=H0FbYPan
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ED5D60D66;
	Wed, 11 Nov 2026 21:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FiEbeESbWtHZ; Wed, 11 Nov 2026 21:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D461660DCB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432379;
	b=XCuQ3x0OFMwtO2vrRQADsB6Q+Qzif+3Yzzu/jpSdufgdJVcNkREkQ6loO85iw9KGS+0Y
	 9GHzGiYTgMD8lG4K3P+bbffdAzyzFnZ/3WgiczvziN9dRYQLq0gjawiMzcm+ACeSC5n55
	 iBL50aFDH17T7+x4S+HOAN3nGDjrI5P7heIyvl890d+KKLxMBZ89ESW0a5lsPVVCEvzVY
	 XZj/wTzINsJtOZgN6DCfvoNoXPzgD2Fjat1AvvuQajyD4t8kWASaJunDUY4r9W3URxUlC
	 dkyO8W45+8e0oETp3UMi4M2I5FD3pn5CcopwtADwl/DOHeJbIk0YJjIIV/zqhd7+c2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eH9071sz7ooEFnAsPtaUD8NUfVx3kQYmwKyaeU8FtFA=;
	b=V7H+ecs1D7Cbk7GMPmCWZVI+3Ece38ru0VuZ+Rnm235PYJ5JozjQUNIL6Bepn9l+MW1N
	 InSDLrErzFe24BQs7jBPX34W/rolADxFcQsVNxtR8B7lhQi0Ymby4UR4YB/T7VG02CjgU
	 OKJOJ7l+h+uh8kQmmmP7p6VLH6gF6wxZlcgjtnUD2m8JqdcDlt92aL5NGJqYm9OMIBtJU
	 2zmLMLvFe8uqBSveNMMYmPllO4SVMRNRsAbzCu5xYlyPHJFN70b72SI6V4GmZCOmsO90S
	 mBOYEbmzXFlK6uVVDp4StRhyBG5RKxyVq3GnoG0judeXqPkVPb3E9OpgyNoZTyesD8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432379;
	bh=eH9071sz7ooEFnAsPtaUD8NUfVx3kQYmwKyaeU8FtFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bqjtR9LR7VY8j4ESebcot1UkqrQ4pB47D7awmXYpyAXX5Sq2xDO8wpfl+tMw0BdcO
	 AcITIBkjMfgh663CW/hTB84nEhcfgdOOEkuBYaPiHMerC1TX2cQEoaAdDVIfpFPwMW
	 q4FFN4J+/BGI1Z0aYU9ZgZuPvtrKIE6u8q6I+10mDksSP5YPlsYaCMX/cG3BcM6Q+P
	 cTwn8vxkV2JgFaNvknNMozVczaf/mJIRZSwtH01+rW3hEP9cqjSv5mcMiPZFYNcz9Y
	 GXIZ6jEJUlNuyxOfXMVHFR/3z+kSKRvxaq+dJA858KOMObRnMwZ5KGa7fyHuDBB8lB
	 OW7sKVEhQM0Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D461660DCB;
	Wed, 11 Nov 2026 21:26:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05174E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF9BE8121A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUi-H3RFn0LY for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37C3C81213
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=H0FbYPan
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37C3C81213
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-85f39332862so1482425a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432370; x=1795037170;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eH9071sz7ooEFnAsPtaUD8NUfVx3kQYmwKyaeU8FtFA=;
 b=H0FbYPanbyIBz65TQ9p389WFuRyY5P0pzOf3BkubfbpOs2ury7Ca+cG1QWZI0mEU0O
 75dkWgL3J8DrROXu0oRt4tmEnwrynqIyaABEwGD7gPRLCay7HwAkvdi/SISD+TEBHQ31
 Ry/jHwaT4+rKckBzXxNFaw/emAia19iMvAXFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432370; x=1795037170;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eH9071sz7ooEFnAsPtaUD8NUfVx3kQYmwKyaeU8FtFA=;
 b=tvDmU3vMTApLDf0Gnn/TQZT3+kLJ8rGs4JVsaM2VkNzXnV7WzxOoBFVjWjtB/6qa4f
 a3K0pJ7kAkmKBteGE/UNRbQ6zIpALzoZeN3hrIiy4kyp1OEy9bTK2eNKsl1P4i72GufL
 +Z3K3nJNHtNlTMD0OnLreGuZm0MEbUBiXWq8+CocDWIYZs/A6IsXt6jMy6+IWJK5YdvU
 vHApqeIocjoPBv3shvQAWboeWZuXHUCzukaZL+mxEKh85FUH//qGgAUHcyvYIPKbavCO
 Dvi6wojzOOpmIb/rQnlWnnL0Klq6ts2rQdyGfw66efy6WSe/bf9Iqr1waLHPUFKyayMb
 f5oQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEvSYqZu+fy3vHaIJ33iEUY0cSupciJgDShnBt5k9pt/T4XIAVbIFIRFPuV8BImeIZxnPIesoc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z86bZMTdeHtJ+9kX/M3uX9BYAqkmtNAwMa5Rn6NDTUMEGKZ4YNI
 KD3tGEeA9X8U3w9qknT7K1ttC0CVrp5uLHLiB8RzsS13oj1UVqj6iKZsrUGwgykJz5E=
X-Gm-Gg: AYBFou1c1/FyqQ2el9ZyDwx3G6rPsVtJiiKotsQe+pZ1M7Pb0kf261LXtrt2+fLQp+V
 0b2oSGIxGbz13H2hbg6gJ0yYpdIr89fWdM09P655TdfxZgQiSKZl5v0y2WP7l4JKlMIKDP9gSfa
 TtAv0rFM2e7psqK2zF6msY5WjK/WbQ2C3KM8tHRSDtw/X9v8NqinM1bU49KY0GKKV8J/eLQ1qOF
 AKXymv5i8TNs1ElLy1UZr11DheZkTX5tetw2ppV/p+hZv0oEgWQZu1wR0uNdgj/t4FW2p7FqEpi
 M2wAN3/2yKEn3aqI6loMmvREdbJD2OAxhH8p4aWUNz5BoNezku4I/+zzjyicIqC/LDscHQJHqR4
 yQn7uPcshmQdBA5oDzq5hc/h7OWBSwOrE2wsW/3lVguTGPmvEtYgm+qa/mA799u6TQKZVsTk5gR
 aLw51RE2p2ZrRLi48O+LnrPwlgbcyw3UGXo0Lfi48fRCMUe47HDyAZIhxkbwJX6W5JGbRPMyv/A
 v3D576j2oTunswmcjpbpSBjgYigWXD13Jk3VjhksJuudrCaUkm704Kv5WUFFfx1lZN56xV+aRRc
 1H5zudh8fvYYaHOI8+rW7Cu3fRT0t1sZy+ME9uXcy7RUPutkQrVQQXpfM2hAu9gV4G+jNtEypTG
 zwPdS1BKNkKQd/jfqNKJY3kvntWfhwVHZ72yqoqm7Ba50vnYcQNWn8HnrhmSOHIw1dRznKIdKF/
 s3j+QvRtnV0ZnooYuDYIi4wlaGJDtnFQ==
X-Received: by 2002:a05:6830:4ac9:b0:812:c5fe:5e4e with SMTP id
 46e09a7af769-860f28cca04mr4537426a34.19.1794432370658; 
 Wed, 11 Nov 2026 13:26:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20261102-upstream_soc_clk_enable-v1-1-3b769d629121@aspeedtech.com>
References: <20261102-upstream_soc_clk_enable-v1-1-3b769d629121@aspeedtech.com>
Subject: Re: [PATCH] clk: ast2700: fix the gate clock enable
Message-Id: <179443236967.664252.16538897532530754700.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:09 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 15:47:26 +0800, Ryan Chen wrote:

> The SoC0/SoC1 clock enable callbacks use the clock ID as the bit in the
> clock stop register. The IDs from dt-bindings/clock/aspeed,ast2700-scu.h
> are sequential numbers, not bit positions, so most gates are never
> opened and other IDs clear an unrelated gate. For example, the MAC
> clocks stay stopped and the MACs do not work in U-Boot.
> 
> Map each clock ID to the offset and bit of its gate in a struct
> ast2700_clk_info table, as the Linux clk-ast2700 driver does. An
> unknown clock ID or a clock that is not a gate returns an error.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] clk: ast2700: fix the gate clock enable
      commit: d90dbb976c1baa6c091bd1ff68ac5f2eb7ccb31e
-- 
Tom


