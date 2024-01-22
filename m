Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB93C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1897D8792D;
	Mon, 22 Jan 2024 19:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="VJ6dfMOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46371878BA; Mon, 22 Jan 2024 19:46:17 +0100 (CET)
Received: from mx0a-00105401.pphosted.com (mx0a-00105401.pphosted.com
 [67.231.144.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E2487B36
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346907.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MGW4Li019288; Mon, 22 Jan 2024 18:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=POD051818; bh=AWeaNKGtQwqe18gjc19KhBp3WV2GQhP7Hu52uSLv2xw=;
 b=VJ6dfMOEwEhRqFC9ePj1hqhRJw5mP9kIuWxK5W76k5SYAJyU0GZEFK5Ek+7DtVmKhQdP
 OiK5T6Nbv1LelCBla27ZpezMtU9THPcRNaJ+wxZ+ZQFb/LMKhOKnWAMCqzAEPQYivDb3
 6CkVhRgdXZfKFw8JyUXBTR+11bN4tcefFZceDYKFbZuBLyDHrQNGxyqcJtY8oBm/2NYW
 OqfJPDM3BdQF6pmh61D9o3KM5p72/Hy9OEjwT4aIsn+dT62AhmCe74K4juvyiPagT46E
 qONBO7oKHAofP3vI1GPfAeMJT8ER6Qs4O8L800RCa0obQCHbet4nqS9IZF81mAsSHklp ag== 
Received: from xusxph008rp050.rtx.com (xusxph008rp050.rtx.com [128.13.124.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3vsuyehhuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 18:46:11 +0000
Received: from xusxph009rp020.corp.ray.com ([128.13.125.224])
 by xusxph008rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 40MIkA3K003571
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Jan 2024 18:46:10 GMT
Received: from dtulimr02.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph009rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 40MIk9BN006918
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 22 Jan 2024 18:46:09 GMT
X-Received: from bspbox.kirk (kirk.rockwellcollins.lab [10.148.204.208])
 by dtulimr02.rockwellcollins.com (Postfix) with ESMTP id 32BFC2006C;
 Mon, 22 Jan 2024 12:46:09 -0600 (CST)
From: Brandon Maier <brandon.maier@collins.com>
To: u-boot@lists.denx.de
Cc: Brandon Maier <brandon.maier@collins.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] scripts/gen_compile_commands: update to Linux v6.7
Date: Mon, 22 Jan 2024 18:45:50 +0000
Message-ID: <20240122184553.69014-1-brandon.maier@collins.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_08,2024-01-22_01,2023-05-22_02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_08,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=777 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220132
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=754
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220131
X-Proofpoint-ORIG-GUID: Z3LXrF5xI1AIzaYTYyrthLUkRcLRCY1P
X-Proofpoint-GUID: Z3LXrF5xI1AIzaYTYyrthLUkRcLRCY1P
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 priorityscore=1501 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=898 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220132
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

Adds support for assembly files and updates the LINE_PATTERN so it
supports both "cmd" and "savedcmd", which allows reverting the U-Boot
modification in commit 97fbb2eb016b ("scripts/gen_compile_commands.py:
adapt _LINE_PATTERN").

Upstream commits:

- 880946158b011 gen_compile_commands.py: fix path resolve with symlinks in it
- 9e56d3be4bfd2 gen_compile_commands: Sort output compile commands by file name
- 52c15e7e79285 gen_compile_commands: Allow the line prefix to still be cmd_
- 1c67921444bf6 gen_compile_commands: add assembly files to compilation database

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>
---

 scripts/gen_compile_commands.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index cdca85e6b07..fec513e5547 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -21,7 +21,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'

 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
+_LINE_PATTERN = r'^(saved)?cmd_[^ ]*\.o := (?P<command_prefix>.* )(?P<file_path>[^ ]*\.[cS]) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
@@ -66,7 +66,7 @@ def parse_arguments():
     args = parser.parse_args()

     return (args.log_level,
-            os.path.abspath(args.directory),
+            os.path.realpath(args.directory),
             args.output,
             args.ar,
             args.paths if len(args.paths) > 0 else [args.directory])
@@ -174,8 +174,8 @@ def process_line(root_directory, command_prefix, file_path):
     # by Make, so this code replaces the escaped version with '#'.
     prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')

-    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
-    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
+    # Return the canonical path, eliminating any symbolic links encountered in the path.
+    abs_path = os.path.realpath(os.path.join(root_directory, file_path))
     if not os.path.exists(abs_path):
         raise ValueError('File %s not found' % abs_path)
     return {
@@ -215,15 +215,15 @@ def main():
                 result = line_matcher.match(f.readline())
                 if result:
                     try:
-                        entry = process_line(directory, result.group(1),
-                                             result.group(2))
+                        entry = process_line(directory, result.group('command_prefix'),
+                                             result.group('file_path'))
                         compile_commands.append(entry)
                     except ValueError as err:
                         logging.info('Could not add line from %s: %s',
                                      cmdfile, err)

     with open(output, 'wt') as f:
-        json.dump(compile_commands, f, indent=2, sort_keys=True)
+        json.dump(sorted(compile_commands, key=lambda x: x["file"]), f, indent=2, sort_keys=True)


 if __name__ == '__main__':
--
2.43.0
