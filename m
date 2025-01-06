Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64935E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 13:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7232801E8;
	Mon,  6 Jan 2025 14:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HhVwHCgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48740803DC; Mon,  6 Jan 2025 07:36:38 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B10801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 07:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-vm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5066aTGv2378168
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 00:36:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736145389;
 bh=ePjqH8MlSrKHfeCIgo60Sq826ofP54Rbj+tKiMbdFmU=;
 h=Date:To:CC:From:Subject;
 b=HhVwHCgKjuRgSRWZO+Qq5N6sViCeKRhN5dklRIX2ULADnxaYVPgU8HK7jaBCuy0V4
 WxBCL5wQRjC2OFZ6OLrHVSgt3yYqdBbheWmRI9vnQLxr3wUUSqvAm1j/26bTOhNBHz
 7D1IKMaCmTrWJVc0db61KK5Xx6ym4I3yyUqM8HxE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5066aToM112126
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 00:36:29 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 00:36:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 00:36:28 -0600
Received: from [10.24.69.179] ([10.24.69.179])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5066aP6K075207;
 Mon, 6 Jan 2025 00:36:26 -0600
Message-ID: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
Date: Mon, 6 Jan 2025 12:06:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: <trini@konsulko.com>, <sjg@chromium.org>, <angus@akkea.ca>,
 <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <kamlesh@ti.com>, <d-gole@ti.com>,
 <k-malarvizhi@ti.com>, <a-parmar1@ti.com>
From: Harsha Vardhan V M <h-vm@ti.com>
Subject: Proposal for a New Command to U-Boot Fuse Programming
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 06 Jan 2025 14:14:51 +0100
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

I would like to propose a new command for U-Boot's fuse programming 
functionality to address the challenges posed by the current 
implementation. While the existing fuse prog command works well for 
programming individual fuse values, it becomes cumbersome especially 
when dealing with large-scale programming requirements.

Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexval>...]

This command programs one or more fuse words starting from a specific 
<bank> and <word> with the hex values given as input.

While functional, it lacks the efficiency and robustness needed for 
programming a significant number of fuses or handling structured fuse 
configuration data. Repeatedly specifying values for each fuse bank and 
word is not only time-consuming but also prone to errors during manual 
input or scripting. This approach does not leverage the ability to 
process pre-structured data in memory. For users with complex 
programming needs, the current method becomes an obstacle rather than a 
tool.

Proposed Command: fuse writebuff

NAME
fuse writebuff - Program fuse data using a memory-based structured buffer.

SYNOPSIS
fuse writebuff <command_id> <addr>

DESCRIPTION
The fuse writebuff command provides a new method for programming fuses 
by leveraging a structured buffer in memory. Instead of requiring 
explicit <bank> and <word> parameters for each fuse word, this command 
operates on a structured buffer in memory at <addr>, that contains all 
the necessary data and programming details, allowing bulk or structured 
programming in a single operation. This approach simplifies workflows, 
reduces manual input, and improves flexibility for complex programming 
scenarios.

PARAMETERS
• <command_id>
Specifies the programming mode or indicates how the buffer data should 
be interpreted. This parameter is a u32 value that identifies the 
operational context or configuration for the programming process. 
Examples of command_id usage might include:
  • A programming mode
  • A specific interpretation of the buffer layout.
  • A mode for validating the buffer before programming.

• <addr>
The starting memory address of the buffer containing the structured fuse 
programming data. This parameter is of type ulong and points to a block 
of memory where the programming data and any associated metadata reside.

USAGE
The fuse writebuff command reads the buffer at <addr> and interprets it 
according to the specified <command_id>. The structure of the buffer 
should contain all necessary details for programming fuses, such as the 
values to be written to the fuse, optional metadata for validation or 
programming constraints and any configuration data required for the 
operation.

EXAMPLES
1. fuse writebuff 1 0x80000000
In this example:
•    command_id is 1, specifying a particular programming mode or a 
buffer format.
•    addr is 0x80000000, pointing to the starting memory address where 
the structured buffer resides.

RETURN VALUES
• 0: The operation was successful.
• Non-zero: An error occurred during the operation. Errors may include 
invalid command_id, inaccessible memory at <addr>, or issues with the 
buffer contents.

The corresponding function, fuse_writebuff(u32 command_id, ulong addr), 
would process this data in a single invocation. This approach 
significantly streamlines and simplifies workflows where fuse 
programming involves predefined rules or structured data, enabling users 
to prepare a struct buffer in memory that encapsulates the entire fuse 
programming configuration. I believe fuse writebuff simplifies 
workflows, reduces error risks, and provides the extensibility needed 
for advanced usage scenarios like programming large or complex fuse 
configurations.

Request for Feedback

Does this proposal look good? If so, I will start to work on an RFC 
patch to implement the proposed changes.

Best regards,
Harsha Vardhan V M
h-vm@ti.com
