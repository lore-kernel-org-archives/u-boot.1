Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4180E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 12:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C499805DF;
	Mon,  6 Jan 2025 13:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YaQqRgl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96217801C3; Mon,  6 Jan 2025 13:40:33 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663AB801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 13:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d8c1950da7so13375146a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 04:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736167231; x=1736772031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szfdI5p8TcahmLHOxAaWHU6zb2Bxdwa5Emv8oPRNK08=;
 b=YaQqRgl0J86LvBTdDUPxY21SsNt57PpGm9PJcizHVf0EMmy6uXjODTsNohj/yoR+ua
 jcIWZLuocmUk5acQAm8Nw9P++AlETa1WymqiZVY+298W4lrsObR9ygNJhZtj9F7j0RB2
 sk7IbCesn8ee3/ErtO0k3MIOrFODPCdz9hKRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736167231; x=1736772031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szfdI5p8TcahmLHOxAaWHU6zb2Bxdwa5Emv8oPRNK08=;
 b=DHfncdi+v0Fc32196HJ6lB+b+ikWixGKK4J25h+R7480l6ikWisyKhK1814KLruW0Y
 l3cHISne3mvK1qYwFv62Y0UMcVfgZAlgsEaDbln8rBErf4vkcwQV0kzgzdeviGk1BLvv
 fnaN2qBhgpF7HP+gynII8iPjXdyqqDGPZr4DcwZZAmmrvPY8yaph2Aim8q56rK/xepjg
 hE2FZzf4ew7Zii4fvqc3P7j9Kt7P8vHSblENZzLCn1RwIyK3C4rh5tXNNC1E1M+2zISo
 y5asJ4tDZHjJZrb4G0HRlKqnUWe5iifRLCwj0tTf4tLbmeGsS1OY9ho9QL40K46WgIIT
 vB/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYlpxiwLkbVrJNkUXspr5jbmplTLJpum1vjz1tpui7NuatL0QmChg/YaeLvjsXLBeTyrbb0tw=@lists.denx.de
X-Gm-Message-State: AOJu0YyL6TIvOF+5yRtHXlmlGkxFAjWujr5bAs4WqzYKIGuga1QDwhZ5
 LY54molLSk2DuANSlm4rTh9TVe+T3PNs0MUVVN6dbKVENGs0BXwSr7gDUHXk4dbv213x0nZ8iZ7
 94oQSUFt1ZCjv1+6Nh3NWAXwK6VlRn7nfyFuU
X-Gm-Gg: ASbGncs1gUE+uYi00CFvh4va89bA56ePa+0ls9eTqR0J645tAtU7VUVzkqYm0jJt/rY
 e+1Xve7B8g5QtYarjHyE43yMSY27UziiOyxW+np4=
X-Google-Smtp-Source: AGHT+IF11b6mIfVnd6vVFaq3wxHMxWNYj46Ch4aTFzrhF/g8QN4LwnY3GkzEUBHlxHcKebrRjJ/vDapxwCasduU4+S8=
X-Received: by 2002:a17:906:f598:b0:aae:c3c1:1361 with SMTP id
 a640c23a62f3a-aaec3c1186fmr5160589266b.44.1736167230849; Mon, 06 Jan 2025
 04:40:30 -0800 (PST)
MIME-Version: 1.0
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
In-Reply-To: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 05:40:19 -0700
Message-ID: <CAFLszTgiw1oOBCwwy0dBFC464c9vSPnjoRyXbXJY-nFbBs721Q@mail.gmail.com>
Subject: Re: Proposal for a New Command to U-Boot Fuse Programming
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: trini@konsulko.com, angus@akkea.ca, u-boot@lists.denx.de, vigneshr@ti.com, 
 kamlesh@ti.com, d-gole@ti.com, k-malarvizhi@ti.com, a-parmar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Harsha,

On Sun, 5 Jan 2025 at 23:36, Harsha Vardhan V M <h-vm@ti.com> wrote:
>
> I would like to propose a new command for U-Boot's fuse programming
> functionality to address the challenges posed by the current
> implementation. While the existing fuse prog command works well for
> programming individual fuse values, it becomes cumbersome especially
> when dealing with large-scale programming requirements.
>
> Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
>
> This command programs one or more fuse words starting from a specific
> <bank> and <word> with the hex values given as input.
>
> While functional, it lacks the efficiency and robustness needed for
> programming a significant number of fuses or handling structured fuse
> configuration data. Repeatedly specifying values for each fuse bank and
> word is not only time-consuming but also prone to errors during manual
> input or scripting. This approach does not leverage the ability to
> process pre-structured data in memory. For users with complex
> programming needs, the current method becomes an obstacle rather than a
> tool.
>
> Proposed Command: fuse writebuff
>
> NAME
> fuse writebuff - Program fuse data using a memory-based structured buffer=
.
>
> SYNOPSIS
> fuse writebuff <command_id> <addr>
>
> DESCRIPTION
> The fuse writebuff command provides a new method for programming fuses
> by leveraging a structured buffer in memory. Instead of requiring
> explicit <bank> and <word> parameters for each fuse word, this command
> operates on a structured buffer in memory at <addr>, that contains all
> the necessary data and programming details, allowing bulk or structured
> programming in a single operation. This approach simplifies workflows,
> reduces manual input, and improves flexibility for complex programming
> scenarios.
>
> PARAMETERS
> =E2=80=A2 <command_id>
> Specifies the programming mode or indicates how the buffer data should
> be interpreted. This parameter is a u32 value that identifies the
> operational context or configuration for the programming process.
> Examples of command_id usage might include:
>   =E2=80=A2 A programming mode
>   =E2=80=A2 A specific interpretation of the buffer layout.
>   =E2=80=A2 A mode for validating the buffer before programming.
>
> =E2=80=A2 <addr>
> The starting memory address of the buffer containing the structured fuse
> programming data. This parameter is of type ulong and points to a block
> of memory where the programming data and any associated metadata reside.
>
> USAGE
> The fuse writebuff command reads the buffer at <addr> and interprets it
> according to the specified <command_id>. The structure of the buffer
> should contain all necessary details for programming fuses, such as the
> values to be written to the fuse, optional metadata for validation or
> programming constraints and any configuration data required for the
> operation.
>
> EXAMPLES
> 1. fuse writebuff 1 0x80000000
> In this example:
> =E2=80=A2    command_id is 1, specifying a particular programming mode or=
 a
> buffer format.
> =E2=80=A2    addr is 0x80000000, pointing to the starting memory address =
where
> the structured buffer resides.
>
> RETURN VALUES
> =E2=80=A2 0: The operation was successful.
> =E2=80=A2 Non-zero: An error occurred during the operation. Errors may in=
clude
> invalid command_id, inaccessible memory at <addr>, or issues with the
> buffer contents.
>
> The corresponding function, fuse_writebuff(u32 command_id, ulong addr),
> would process this data in a single invocation. This approach
> significantly streamlines and simplifies workflows where fuse
> programming involves predefined rules or structured data, enabling users
> to prepare a struct buffer in memory that encapsulates the entire fuse
> programming configuration. I believe fuse writebuff simplifies
> workflows, reduces error risks, and provides the extensibility needed
> for advanced usage scenarios like programming large or complex fuse
> configurations.
>
> Request for Feedback
>
> Does this proposal look good? If so, I will start to work on an RFC
> patch to implement the proposed changes.

What format is the buffer in? Is it a text file?

Regards,
Simon
