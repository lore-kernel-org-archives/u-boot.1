Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57947CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D37FA40412;
	Tue, 13 Oct 2026 14:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kHxAqkl27-N0; Tue, 13 Oct 2026 14:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D78A1403DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903491;
	b=Q7rnVWNP9tP6d+8IUKXOAOE5e8kQ4vVF/a8VgPqdDyOqpb2qOsf5F039HENT6gQmaHTo
	 /wBpJ7RqYUnzpdY4O1wGkdu8S8zL/IZR4dndW/AZufDcBBFJTY6fvcTZ+AlorX0II5j1y
	 bVzrUIQpDrF4g+ouNardDx4kOTMhi3TqNlySnKXZwL4Dv0hPO9F528xLR/Auy1iSf3o3h
	 gOmvBbBBZgYiwNwE9btFAvIBYrehCE/+7OQ9DgAmrJ6PYAk2OtP0Vf9JW9Pncpxn0lZxG
	 twX4kYzQjocg7xKPyBqQakcwQFOpCN6ynLu51iXkv8tOsfezyNfCz+2cRPkOu/UnkxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sjUo3yqV2ZDbzCj3BL4DmZ0sxX+AawJ9jmupNNWwokA=;
	b=fyMcPTUSiji1ggjZIfBXJ4wNjAODKS1Pkp8xjxFbwqYVG3Hli+i1ext77xKMx27HtOjX
	 lSGTxLukjkaXGHZg13CzfONwQNbrC0Gnyfzd7hBnpl+0lcqFGd8icQQL0viIJeqzBqG66
	 RE0UClQcH383ADwcYna1WKonw+Ft5JCC4NxFL70cq17iInP06bsDyxqX1BGvnCUOghByU
	 F7DY5VRUBLWYGDPooYdf7b8M1P23SmmcRm5oIDDftFXaWyvgsHXXi+RKzUebPGsD9IQ8h
	 MGJGvsWbaLZ9j379kJvGhngWQNydZ9plxBPB2VqFMCnwnYDw8vPoYSg1mZAxsRHnw9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903491;
	bh=sjUo3yqV2ZDbzCj3BL4DmZ0sxX+AawJ9jmupNNWwokA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXyYom3Brx2CwGU8PjVacmIt03Ab//Dqor6aTPfA3ERUPQWnHFPPQepp6NSzKVoW5
	 tHZav4EBrLUjrCiOiH0L1XYdU6bLylnOV6dhYRwvJqzWofAkK3fWhov4VhuAxpvSes
	 9c2H+aeWWNSwrudcSplDbGv+gyg0vERwI5Rv3qVDmQ/1odjAtN0mBAbbgH+Q5p8BJK
	 J9H8fwFXASUPHLuJz9wfpxXKAAqILCjZYU+Ue2MMfyrWq9IQDR5pzmeUI1abAPubxf
	 0azH8aLXe8vmXTMKT6oKPJD3nO0JkZ3uiLcI5ZZunsZaxn+tu9g6VypW+1/OhIqtqg
	 yVDhWDA05yiQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D78A1403DE;
	Tue, 13 Oct 2026 14:58:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34BA175
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B40A402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLDm0G5HzoZJ for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C3FDD401EC
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791903489;
 b=lnYA8ZXf3dC63ZYvqivCAY6H+IMhAfrT+4+L2vAyORjZ+nvADqJNmIwd63FQQI5OwfC2
 /VJQGiRnd2B6ahEuxZ+XqlOC5hW0BasJC8u2mdhxhgCgorBlNSz5qAdM8MNXKJp5K+M7G
 7PUb78DAWQFuYZB28nR4fgwk4jXNngiBaiPoAfYafvrrqvnMZ2duAwxUU/iSnx+EvS+w4
 6xxIYKB6s7pSeqARKNIMEd81xgLdCIebfEnR4z25Qcrg5dex+E1HFh8j+7uIgHoCQuN7c
 pkKzPNudOsX+VWbMRlLpZOEo5B7RS3OzjhWJXLaV9XVj1xGP4kwUk2DPFSSHCFCabAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903489;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=sjUo3yqV2ZDbzCj3BL4DmZ0sxX+AawJ9jmupNNWwokA=;
 b=IrYt/WGRYbnctu0rak+tA338nxd3eplROGEXkKSCxYwxSKRb+16yGvGEZX6GCHGIhD3H
 bzBwhRwsqK5FZM4JpfRMAlqjwiw0foLYaoBxOEyNcT7m9KKyQ5fChWMqnTBDq9C7oJ0RT
 57OZZ/Ld3WBoaRtJt/Y4ZkU48ZLmN3noV6A0MVm39vteLZqGKj/yffDt5/C74HQzKvegn
 BIpmV/xoUfgHnhjAPicyZ5c0XiCVsVkcRs+lYuxaXhjX8Bmp2uE0SRVL/RYMZ90PCztX2
 gSZS1AYh3bGAUc2xQiW028md0sWs+Gd38yOz5KYvPnv0M8Jp80WOfLOLXbHamB3jM4Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=elTGugXr; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=elTGugXr
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3FDD401EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:58:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 312D060A52;
 Tue, 13 Oct 2026 14:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6884C1F000FF;
 Tue, 13 Oct 2026 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903486;
 bh=sjUo3yqV2ZDbzCj3BL4DmZ0sxX+AawJ9jmupNNWwokA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=elTGugXrrBwtQEtSOLmOofpdrW8/4Zxl6+fAuAcYj96dF0s37DgKV9wQKAVXCDuqY
 frqSpthTDADlre1qoRyBfTGsgavd4yorpar/Po5g/zpByVT0eX3bC5vaJMPiVmy2i/
 4KahxLgKfODDAFd5DGarE/dJKQShboid24pGYkZ8FiUfdB7zbug6ovsMvA6aYkSkLI
 EL7WZubwBWGsxmgo/V0l1hrR+vPnZ6kUeBee1H6xo4SS7z5VLrkYgQ0fTwp0vwkw8+
 VNhUpnoQdAL3EnQEAc1zx8Wwh67lNxw3e/Fo7HUXBhxIJVxfWJBImAQQQmoslJQ3Rv
 2xAPTgp5J0kTA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: TOCTOU issues in AVB?
In-Reply-To: <CAByghJbn0+1hEt6Crfa4gKkWKBkgaLaYbRE4AmPm1GqTtaqgtw@mail.gmail.com>
References: <e45caa4f-8ae0-4c0c-a3e9-6009b68f3400@pengutronix.de>
 <CAByghJbn0+1hEt6Crfa4gKkWKBkgaLaYbRE4AmPm1GqTtaqgtw@mail.gmail.com>
Date: Tue, 13 Oct 2026 16:58:04 +0200
Message-ID: <xhkdbecdt7imb.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Ahmad,

On Wed, Oct 07, 2026 at 08:03, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> Hi Ahmad,
>
> On Mon, Oct 5, 2026 at 11:34=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutroni=
x.de> wrote:
>>
>> Hi.
>>
>> I am quite ignorant about how Android Verified Boot works, but looking
>> through the code in both cmd/avb.c and bootmeth_android.c, I wonder how
>> this could not be susceptible to a TOCTOU attack:
>>
>> - do_avb_verify_part() does avb_slot_verify() and then discards what it
>> verified with avb_slot_verify_data_free()
>>
>> - run_avb_verification() leaks AvbSlotVerifyData *out_data and doesn't
>>   seem to use it anywhere

I believe the leak you mentions has been reported and fixed by Igor here:
https://lore.kernel.org/all/20260712-avb-fix-memory-leaks-v1-1-51d6d5a42631=
@gmail.com/

>>
>> So it looks like an attacker able to interpose the storage device should
>> be trivially able to circumvent both of these? Am I missing something?
>>
>> Cheers,
>> Ahmad
>>
>> --
>> Pengutronix e.K.                           |                            =
 |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/ =
 |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0   =
 |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555=
 |
>>
>
> You're right, and this is a known limitation rather than a new finding.
> Initially, the verification and loading steps were never designed to
> share bytes (and it was a deliberate trade-off).

For the TOCTOU part, I agree with Igor, you are totally right.
Thank you for reporting this.

It looks like Igor submitted a series that is fixing this here:
https://lore.kernel.org/all/20261012-upstream-avb_lock_unlock_b4-v2-3-87460=
a24e559@oss.qualcomm.com/

Regards,
Mattijs

>
> The gap comes from how the feature grew in two steps.
>
> 2018: avb verify was added as a shell command. It landed in the
> boot-script era, where the only way to pass data between commands is
> the environment. So the command exported what fits in a string, the
> cmdline, returned pass or fail, and freed libavb's buffers. Boards
> already had mmc read plus bootm sequences, and the command was dropped
> in as a gate in front of them. The threat model was offline flash
> tampering, where verify-then-reread is sound. libavb's
> get_preloaded_partition op was in the tree but never implemented, since
> the shell contract had no way to pass load addresses.
>
> 2024: the bootmeth basically reimplemented the same steps as was done in
> the script. The commit message describes it as a rewrite of the
> meson64_android.h script
> and lists "run AVB" and "load boot partitions" as separate steps. The C
> code mirrors that, using the sizes recorded at bootflow scan and a fresh
> read into loadaddr. Copying tens of megabytes out of libavb's heap
> buffers looked wasteful, and the preloaded path would have meant
> restructuring to load first and verify in place.
>
> I was planning to address that, it's on my todo list, but I haven't
> found the time yet to play with this.
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
